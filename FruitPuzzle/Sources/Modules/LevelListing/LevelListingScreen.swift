//
//  LevelListingScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct LevelListingScreen: View {
    // MARK: - Setup
    @ObservedObject var viewModel: LevelListingViewModel
    @Binding var path: NavigationPath
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
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                    ForEach(viewModel.items, id: \.self) { item in
                        LevelView(viewModel: item, onTap: { _ in
                            path.append(Router.game(item))
                        })
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(selectedBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .onAppear {
            viewModel.reloadData()
        }
    }
}

#Preview {
    LevelListingScreen(viewModel: .init(items: [
        .init(id: "1", level: 1, isResolved: true),
        .init(id: "2", level: 2, isResolved: false),
        .init(id: "3", level: 2, isResolved: false),
        .init(id: "4", level: 2, isResolved: false),
        .init(id: "5", level: 2, isResolved: false),
        .init(id: "6", level: 3, isResolved: false)
    ]), path: .constant(.init()))
}
