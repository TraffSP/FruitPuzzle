//
//  SettingsScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct SettingsScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedBackground") private var selectedBackground: String = "mainBackground"
    
    let backgrounds = ["mainBackground", "background1", "background2", "background3", "background4", "background5"]
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
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
            Text("Change background")
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .textCase(.uppercase)
                .font(Font.system(size: 26, weight: .heavy, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 12) {
                ForEach(backgrounds, id: \.self) { background in
                    Image(background)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(
                                    background == selectedBackground
                                    ? LinearGradient(colors: [
                                        Color(red: 225/255, green: 102/255, blue: 105/255, opacity: 1),
                                        Color(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.8)
                                    ], startPoint: .top, endPoint: .bottom)
                                    : LinearGradient(colors: [
                                        Color(red: 204/255, green: 18/255, blue: 255/255, opacity: 0.7),
                                        Color(red: 255/255, green: 18/255, blue: 172/255, opacity: 0.7)
                                    ], startPoint: .top, endPoint: .bottom)
                                )
                                .shadow(color: Color.init(red: 158/255, green: 0/255, blue: 110/255), radius: 0, x: 0, y: 3)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedBackground = background
                            }
                        }
                        .padding(0)
                }
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(selectedBackground)
                .resizable()
                .ignoresSafeArea()
                .transition(.opacity)
                .animation(.linear, value: selectedBackground)
        )
    }
}

#Preview {
    SettingsScreen(path: .constant(.init()))
}
