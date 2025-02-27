//
//  ViewController.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let onboardingScreen = OnboardingScreen()
        let hostingController = UIHostingController(rootView: onboardingScreen)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func openApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let onboardingScreen = RootScreen()
            let hostingController = UIHostingController(rootView: onboardingScreen)
            self.setRootViewController(hostingController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            let webView = SecondViewController(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, advertiseID: String, appsflierId: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?qzhg=\(deviceID)&asnt=\(advertiseID)&vfsp=\(appsflierId)"
        
        return url
    }
}

