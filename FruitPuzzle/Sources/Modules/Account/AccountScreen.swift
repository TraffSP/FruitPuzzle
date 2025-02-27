//
//  AccountScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI
import StoreKit

struct AccountScreen: View {
    @ObservedObject private var viewModel: AccountViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedBackground") private var selectedBackground: String = "mainBackground"
    @State private var isPresentAlert = false
    @State private var isPresentDeleteAlert = false
    @State private var name = ""
    @EnvironmentObject var authViewModel: AuthCore
    
    init(viewModel: AccountViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.back)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                    }
                    .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                    .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                    Spacer()
                }
                Spacer()
                Image(.icon)
                    .resizable()
                    .scaledToFit()
                    .padding(4)
                    .background(
                        LinearGradient(colors: [
                            Color.init(red: 204/255, green: 18/255, blue: 255/255),
                            Color.init(red: 255/255, green: 18/255, blue: 172/255)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(24)
                    .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                    .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                    .padding(.horizontal, 72)

                Text(authViewModel.currentuser?.name ?? "ANONYMOUS")
                    .foregroundStyle(LinearGradient(colors: [
                        .white,
                        Color.init(red: 229/255, green: 160/255, blue: 255/255)
                    ], startPoint: .top, endPoint: .bottom))
                    .font(Font.system(size: 32, weight: .bold, design: .rounded))
                    .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                    .padding(.horizontal, 32)
                Spacer()
                Button {
                    path.append(Router.info)
                } label: {
                    Image(.infoButton)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.horizontal, 24)
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                Button {
                    requestAppReview()
                } label: {
                    Image(.rateButton)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.horizontal, 24)
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                Button {
                    authViewModel.signOut()
                } label: {
                    Image(.logOutButton)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.horizontal, 24)
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                Button {
                    isPresentDeleteAlert = true
                } label: {
                    Image(.deleteButton)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.horizontal, 24)
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                Spacer()
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(selectedBackground)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            )
            
            if isPresentDeleteAlert {
                VStack {
                    Text("Are you sure?")
                        .foregroundStyle(LinearGradient(colors: [
                            .white,
                            Color.init(red: 229/255, green: 160/255, blue: 255/255)
                        ], startPoint: .top, endPoint: .bottom))
                        .font(Font.system(size: 36, weight: .heavy, design: .rounded))
                        .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)

                    HStack(spacing: 24) {
                        Button {
                            authViewModel.deleteUserAccount { result in
                                switch result {
                                case .success():
                                    print("Account deleted successfully.")
                                    viewModel.deleteAccount()
                                    authViewModel.userSession = nil
                                    authViewModel.currentuser = nil
                                case .failure(let error):
                                    print("ERROR DELELETING: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Image(.yesButton)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Button {
                            isPresentDeleteAlert = false
                        } label: {
                            Image(.noButton)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .padding(.horizontal, 32)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(.finishBackrg)
                        .resizable()
                        .scaledToFit()
                )
                .shadow(color: Color(red: 158/255, green: 0/255, blue: 110/255), radius: 3, x: 0, y: 3)
                .shadow(color: Color(red: 255/255, green: 114/255, blue: 221/255, opacity: 0.7), radius: 6, x: 0, y: 0)
                .padding(.horizontal, 42)
                .onAppear {
                    Task {
                        await authViewModel.fetchUser()
                    }
                }
            }
        }
    }
    
    func requestAppReview() {
       if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
           SKStoreReviewController.requestReview(in: scene)
       }
   }
}

#Preview {
    AccountScreen(viewModel: .init(), path: .constant(.init()))
}
