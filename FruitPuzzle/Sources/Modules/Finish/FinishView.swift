//
//  FinishView.swift
//  FruitPuzzle
//
//  Created by muser on 23.02.2025.
//

import SwiftUI

struct FinishView: View {
    @ObservedObject private var viewModel: FinishViewModel
    @Binding var path: NavigationPath
    var onExitTap: (() -> Void)?
    var onNNextTap: (() -> Void)?
    
    init(viewModel: FinishViewModel, path: Binding<NavigationPath>, onExitTap: (() -> Void)? = nil, onNNextTap: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self._path = path
        self.onExitTap = onExitTap
        self.onNNextTap = onNNextTap
    }
    
    var body: some View {
        VStack {
            Text("Your score")
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .font(Font.system(size: 26, weight: .bold, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
            Text(viewModel.time)
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .font(Font.system(size: 46, weight: .black, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)

            HStack(spacing: 24) {
                Button {
                    onExitTap?()
                } label: {
                    Image(.exitButton)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.horizontal, 82)
//                Button {
//                    onNNextTap?()
//                } label: {
//                    Image(.nextButton)
//                        .resizable()
//                        .scaledToFit()
//                }
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
    }
}

#Preview {
    FinishView(viewModel: .init(time: "12"), path: .constant(.init()))
}
