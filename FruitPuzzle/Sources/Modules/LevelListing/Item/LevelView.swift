//
//  LevelView.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct LevelView: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: LevelViewModel
    var onTap: ((LevelViewModel) -> Void)?
    
    init(viewModel: LevelViewModel, onTap: ((LevelViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            if viewModel.isResolved {
                Button {
                    onTap?(viewModel)
                } label: {
                    Text("\(viewModel.level)")
                        .foregroundStyle(LinearGradient(colors: [
                            .white,
                            Color.init(red: 229/255, green: 160/255, blue: 255/255)
                        ], startPoint: .top, endPoint: .bottom))
                        .font(Font.system(size: 46, weight: .heavy, design: .rounded))
                        .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                        .padding(32)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(.levelItem)
                        .resizable()
                        .scaledToFit()
                )
                .shadow(color: Color.init(red: 255/255, green: 114/255, blue: 221/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 158/255, green: 0/255, blue: 110/255), radius: 0, x: 0, y: 3)
            } else {
                ZStack {
                    Text("\(viewModel.level)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .font(Font.system(size: 46, weight: .heavy, design: .rounded))
                        .padding(32)
                        .background(
                            Image(.lockLevelItem)
                                .resizable()
                                .scaledToFit()
                        )
                    Image(.lock)
                        .resizable()
                        .padding(32)
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                }
                .shadow(color: Color.init(red: 56/255, green: 56/255, blue: 56/255, opacity: 0.7), radius: 4, x: 0, y: 0)
                .shadow(color: Color.init(red: 78/255, green: 78/255, blue: 78/255), radius: 0, x: 0, y: 3)
            }
        }
    }
}

#Preview {
    LevelView(viewModel: .init(id: "1", level: 1, isResolved: false), onTap: {_ in })
}
