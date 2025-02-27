//
//  RootScreen.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = AuthCore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
            if viewModel.userSession != nil {
                MainScreen(viewModel: .init())
                    .environmentObject(viewModel)
            } else {
                AuthorizationScreen(viewModel: viewModel)
                    .environmentObject(viewModel)
            }
    }
}

#Preview {
    RootScreen()
}
