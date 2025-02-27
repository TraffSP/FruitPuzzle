//
//  RegistrationScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct RegistrationScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var isNotificationShown = false
    @State private var isAlertShown = false
    
    @ObservedObject var viewModel: AuthCore
    
    var body: some View {
        ZStack {
            VStack {
                Text("Create acc")
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
                
                TextField("", text: $name, prompt: Text("Name").foregroundColor(Color.init(red: 176/255, green: 138/255, blue: 209/255)).font(.system(size: 22, weight: .bold, design: .rounded)))
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
                    .padding(.top, 8)
                
                SecureField("", text: $password, prompt: Text("Password").foregroundColor(Color.init(red: 176/255, green: 138/255, blue: 209/255)).font(.system(size: 22, weight: .bold, design: .rounded)))
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
                    .padding(.top, 8)
                
                SecureField("", text: $confirmPassword, prompt: Text("Confirm password").foregroundColor(Color.init(red: 176/255, green: 138/255, blue: 209/255)).font(.system(size: 22, weight: .bold, design: .rounded)))
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
                    .padding(.top, 8)
                
                Button {
                    if isFormValid {
                        Task {
                            do {
                                try await viewModel.createUser(withEmail: email, password: password, name: name)
                                if !viewModel.text.isEmpty {
                                    isAlertShown = true
                                } else {
//                                    dismiss()
                                }
                            } catch {
                                isAlertShown = true
                            }
                        }
                    } else {
                        isNotificationShown.toggle()
                    }
                } label: {
                    Text("Create acc")
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

                Button {
                    dismiss()
                } label: {
                    Text("Log in")
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
            if isNotificationShown {
                VStack {
                    Text("Incorrect data or user with this email already exists")
                        .foregroundStyle(LinearGradient(colors: [
                            .white,
                            Color.init(red: 229/255, green: 160/255, blue: 255/255)
                        ], startPoint: .top, endPoint: .bottom))
                        .font(Font.system(size: 26, weight: .heavy, design: .rounded))
                        .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                        .lineLimit(4)
                        .padding(.top, 12)
                        Button {
                            isNotificationShown = false
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
        .onChange(of: viewModel.userSession) { newValue in
            if newValue != nil {
                dismiss()
            }
        }
        .animation(.easeInOut, value: isAlertShown)
        .animation(.easeInOut, value: isNotificationShown)
    }
}

#Preview {
    RegistrationScreen(viewModel: .init())
}


extension RegistrationScreen: AuthCoreProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}
