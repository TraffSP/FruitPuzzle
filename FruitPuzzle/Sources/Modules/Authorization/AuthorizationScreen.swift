//
//  AuthorizationScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct AuthorizationScreen: View {
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject var viewModel: AuthCore
    @State private var isAlertShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Log in")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 36, weight: .heavy, design: .rounded))
                    TextField("", text: $email, prompt: Text("Email").foregroundColor(Color.init(red: 176/255, green: 138/255, blue: 209/255)).font(.system(size: 22, weight: .bold, design: .rounded)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding(20)
                        .foregroundStyle(Color.init(red: 176/255, green: 138/255, blue: 209/255))
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(24)
                        }
                    //                    .shadow(color: Color.init(red: 255/255, green: 57/255, blue: 255/255, opacity: 0.6), radius: 3, x: 0, y: 3)
                        .padding(.top, 20)
                    
                    SecureField("", text: $password, prompt: Text("Password").foregroundColor(Color.init(red: 176/255, green: 138/255, blue: 209/255)).font(.system(size: 22, weight: .bold, design: .rounded)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding(20)
                        .foregroundStyle(Color.init(red: 176/255, green: 138/255, blue: 209/255))
                    //                    .padding(.horizontal, 12)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(24)
                        }
                        .padding(.top, 10)
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.signIn(email: email, password: password)
                                if !viewModel.text.isEmpty {
                                    isAlertShown = true
                                }
                            } catch {
                                isAlertShown = true
                            }
                        }
                    } label: {
                        Text("Log in")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundStyle(Color.init(red: 81/255, green: 0/255, blue: 63/255))
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .textCase(.uppercase)
                            .lineLimit(1)
                    }
                    .background(
                        LinearGradient(colors: [
                            Color.init(red: 204/255, green: 18/255, blue: 255/255),
                            Color.init(red: 255/255, green: 18/255, blue: 172/255)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(32)
                    .padding(.top, 24)
                    .padding(.vertical, 6)
                    .shadow(color: Color.init(red: 158/255, green: 0/255, blue: 110/255), radius: 0, x: 0, y: 3)
                    .shadow(color: Color.init(red: 255/255, green: 114/255, blue: 221/255, opacity: 0.7), radius: 3, x: 0, y:0)
                    Text("or")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 20, weight: .heavy, design: .rounded))
                    NavigationLink(destination: RegistrationScreen(viewModel: viewModel).navigationBarBackButtonHidden(true)) {
                        Text("Create acc")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundStyle(Color.init(red: 214/255, green: 198/255, blue: 255/255))
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .textCase(.uppercase)
                            .lineLimit(1)
                            .background(
                                LinearGradient(colors: [
                                    Color.init(red: 73/255, green: 18/255, blue: 255/255),
                                    Color.init(red: 212/255, green: 18/255, blue: 255/255)
                                ], startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(32)
                            .shadow(color: Color.init(red: 108/255, green: 0/255, blue: 133/255), radius: 0, x: 0, y: 3)
                            .shadow(color: Color.init(red: 150/255, green: 88/255, blue: 255/255, opacity: 0.7), radius: 3, x: 0, y:0)
                    }
                    
                    Button {
                        Task {
                            await viewModel.signInAnonymously()
                        }
                    } label: {
                        Text("Anonymous")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundStyle(Color.init(red: 214/255, green: 198/255, blue: 255/255))
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .textCase(.uppercase)
                            .lineLimit(1)
                    }
                    .background(
                        LinearGradient(colors: [
                            Color.init(red: 73/255, green: 18/255, blue: 255/255),
                            Color.init(red: 212/255, green: 18/255, blue: 255/255)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(32)
                    .shadow(color: Color.init(red: 108/255, green: 0/255, blue: 133/255), radius: 0, x: 0, y: 3)
                    .shadow(color: Color.init(red: 150/255, green: 88/255, blue: 255/255, opacity: 0.7), radius: 3, x: 0, y:0)
                }
                .padding(.horizontal, 32)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(.mainBackground)
                        .resizable()
                        .ignoresSafeArea()
                )
                if isAlertShown {
                    VStack {
                        Text(viewModel.text)
                            .foregroundStyle(LinearGradient(colors: [
                                .white,
                                Color.init(red: 229/255, green: 160/255, blue: 255/255)
                            ], startPoint: .top, endPoint: .bottom))
                            .font(Font.system(size: 26, weight: .heavy, design: .rounded))
                            .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                            .lineLimit(4)
                            .padding(.horizontal, 22)
                            .padding(.top, 12)
                            Button {
                                isAlertShown = false
                            } label: {
                                Image(.yesButton)
                                    .resizable()
                                    .scaledToFit()
                            }
                            .padding(.horizontal, 94)
                            .padding(.bottom, 12)
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
                    .background(Color.black.opacity(0.8))
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: isAlertShown)
        }
    }
}

#Preview {
    AuthorizationScreen(viewModel: .init())
}
