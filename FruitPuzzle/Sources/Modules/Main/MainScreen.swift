//
//  MainScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

enum Router: Hashable {
    case levelListing
    case rating
    case settings
    case game(LevelViewModel)
    case account
    case info
}

struct MainScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: MainViewModel
    @State private var path: NavigationPath = .init()
    @AppStorage("selectedBackground") private var selectedBackground: String = "mainBackground"
    @EnvironmentObject var authViewModel: AuthCore
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 12) {
                Spacer()
                Spacer()
                Spacer()
                Button {
                    path.append(Router.levelListing)
                    AnalyticsService.shared.logScreenView(screenName: "MainScreen; PlayButton")
                } label: {
                    Image(.playButton)
                        .resizable()
                        .scaledToFit()
                }
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.6), radius: 0, x: 0, y: 4)
                
                Button {
                    path.append(Router.rating)
                    AnalyticsService.shared.logScreenView(screenName: "MainScreen; ratingButton")
                } label: {
                    Image(.ratingButton)
                        .resizable()
                        .scaledToFit()
                }
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.6), radius: 0, x: 0, y: 4)
                Spacer()
                HStack {
                    Button {
                        path.append(Router.account)
                        AnalyticsService.shared.logScreenView(screenName: "MainScreen; accountButton")
                    } label: {
                        Image(.accButton)
                            .resizable()
                            .scaledToFit()
                    }
                    .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.6), radius: 0, x: 0, y: 4)
                    
                    Button {
                        path.append(Router.settings)
                        AnalyticsService.shared.logScreenView(screenName: "MainScreen; settingsButton")
                    } label: {
                        Image(.settingsButton)
                            .resizable()
                            .scaledToFit()
                    }
                    .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.6), radius: 0, x: 0, y: 4)
                }
                Spacer()
                
            }
            .navigationDestination(for: Router.self) { router in
                switch router {
                case .levelListing:
                    LevelListingScreen(viewModel: .init(items: viewModel.loadlevelsData()), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .rating:
                    RecordScreen(viewModel: .init(items: viewModel.loadRatingData()), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .settings:
                    SettingsScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .game(let item):
                    GameScreen(viewModel: .init(id: item.id, level: item.level) , path: $path)
                        .navigationBarBackButtonHidden(true)
                case .account:
                    AccountScreen(viewModel: .init(), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .info:
                    InfoScreen()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .environmentObject(authViewModel)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(selectedBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
            .onAppear {
                viewModel.viewDidLoad()
            }
        }
    }
}

#Preview {
    MainScreen(viewModel: .init())
}
