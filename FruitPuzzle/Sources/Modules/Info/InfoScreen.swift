//
//  InfoScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct InfoScreen: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedBackground") private var selectedBackground: String = "mainBackground"
    
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
            
            ScrollView {
                Text("Welcome to an exciting maths game where you have to solve mysterious equations made up of delicious fruits! 🍏🍓\n\nEach fruit hides a unique numerical value behind it. Your task is to calculate the correct answers using logic, attentiveness and a bit of intuition. With each new level the difficulty increases and time is limited, so think fast! ⏳💡\n\n🔢 How to play?\n1️⃣ Analyse the clues in the equations.\n2️⃣ Use maths operations to find hidden numbers.\n3️⃣ Enter your answers and check if they are correct!\n4️⃣ Break your own time records!\n\n🎯 Game Features:\n✅ Different levels of difficulty - from simple problems to real maths challenges!\n✅ Interactive timer - the faster you solve, the better your result!\n✅ Colourful and yummy fruits that make maths more fun! 🍌🍍🍎\n\nReady to test your wits? Then go ahead - solve the fruit equations and become a champion of logic! 🏆🔥")
                    .foregroundStyle(LinearGradient(colors: [
                        .white,
                        Color.init(red: 229/255, green: 160/255, blue: 255/255)
                    ], startPoint: .top, endPoint: .bottom))
                    .font(Font.system(size: 22, weight: .bold, design: .rounded))
                    .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
            }
            .padding(.vertical, 12)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(selectedBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    InfoScreen()
}
