//
//  GameScreen.swift
//  FruitPuzzle
//
//  Created by muser on 21.02.2025.
//

import SwiftUI

struct GameScreen: View {
    @ObservedObject private var viewModel: GameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedBackground") private var selectedBackground: String = "mainBackground"
    @FocusState private var isFocused: Bool

    init(viewModel: GameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        ZStack {
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
                    Text(viewModel.formattedTime)
                        .foregroundStyle(LinearGradient(colors: [
                            .white,
                            Color.init(red: 229/255, green: 160/255, blue: 255/255)
                        ], startPoint: .top, endPoint: .bottom))
                        .font(Font.system(size: 36, weight: .bold, design: .rounded))
                        .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                }
                Spacer()
                ForEach(viewModel.equations) { equation in
                    HStack {
                        ForEach(0..<equation.images.count, id: \.self) { index in
                            Image(equation.images[index])
                                .resizable()
                                .scaledToFit()
                            if index < equation.images.count - 1 {
                                Text("+")
                                    .foregroundStyle(LinearGradient(colors: [
                                        .white,
                                        Color.init(red: 229/255, green: 160/255, blue: 255/255)
                                    ], startPoint: .top, endPoint: .bottom))
                                    .font(Font.system(size: 26, weight: .bold, design: .rounded))
                                    .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                            }
                        }
                        
                        Text("=")
                            .foregroundStyle(LinearGradient(colors: [
                                .white,
                                Color.init(red: 229/255, green: 160/255, blue: 255/255)
                            ], startPoint: .top, endPoint: .bottom))
                            .font(Font.system(size: 26, weight: .bold, design: .rounded))
                            .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                        
                        if equation.isHint {
                            Text("\(equation.result)")
                                .foregroundStyle(LinearGradient(colors: [
                                    .white,
                                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                                ], startPoint: .top, endPoint: .bottom))
                                .font(Font.system(size: 26, weight: .bold, design: .rounded))
                                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                                .padding(8)
                                .background(Color.init(red: 217/255, green: 217/255, blue: 217/255, opacity: 0.4))
                                .cornerRadius(12)
                        } else {
                            TextField("?", text: Binding(
                                get: { equation.userAnswer.map(String.init) ?? "" },
                                set: { newValue in
                                    if let value = Int(newValue) {
                                        viewModel.updateAnswer(for: equation.id, with: value)
                                    } else if newValue.isEmpty {
                                        viewModel.updateAnswer(for: equation.id, with: nil)
                                    }
                                }
                            ))
                            .padding(8)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .foregroundStyle(LinearGradient(colors: [
                                .white,
                                Color.init(red: 229/255, green: 160/255, blue: 255/255)
                            ], startPoint: .top, endPoint: .bottom))
                            .font(Font.system(size: 26, weight: .bold, design: .rounded))
                            .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                            .frame(width: 50)
                            .background(Color.init(red: 217/255, green: 217/255, blue: 217/255, opacity: 0.4))
                            .cornerRadius(12)
                        }
                    }
                    .padding(8)
                    .background(
                        LinearGradient(colors: [
                            Color.init(red: 150/255, green: 10/255, blue: 190/255),
                            Color.init(red: 200/255, green: 10/255, blue: 140/255)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(24)
                    .padding(4)
                    .background(
                        LinearGradient(colors: [
                            Color.init(red: 255/255, green: 102/255, blue: 105/255),
                            Color.init(red: 162/255, green: 0/255, blue: 171/255)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(24)
                    .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                    .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                    .padding(.vertical, 8)
                }
                Spacer()
                Button("check") {
                    viewModel.checkAnswers()
                }
                .frame(maxWidth: .infinity)
                .textCase(.uppercase)
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .font(Font.system(size: 26, weight: .bold, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                .padding(24)
                .background(LinearGradient(colors: [
                    Color.init(red: 255/255, green: 18/255, blue: 22/255),
                    Color.init(red: 204/255, green: 24/255, blue: 255/255)
                ], startPoint: .bottom, endPoint: .top))
                .cornerRadius(32)
                .padding(.horizontal, 42)
                .shadow(color: Color.init(red: 162/255, green: 0/255, blue: 171/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 95/255, green: 0/255, blue: 158/255), radius: 0, x: 0, y: 3)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(selectedBackground)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            )
            .onAppear {
                viewModel.generateEquations()
            }
            if viewModel.isCorrect {
                FinishView(viewModel: .init(time: viewModel.formattedTime), path: $path, onExitTap: {
                    viewModel.levelPassed()
                    dismiss()
                }, onNNextTap: {
                    viewModel.levelPassed()
                    print("next")
                })
                .padding(.horizontal, 42)
                .background(Color.black.opacity(0.8))
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: viewModel.isCorrect)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(viewModel: .init(id: "1", level: 1), path: .constant(.init()))
    }
}


