//
//  RecordItemView.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI

struct RecordItemView: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: RecordItemViewModel
    
    init(viewModel: RecordItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("\(viewModel.level)")
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .font(Font.system(size: 42, weight: .heavy, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
            Text(formattedTime)
                .foregroundStyle(LinearGradient(colors: [
                    .white,
                    Color.init(red: 229/255, green: 160/255, blue: 255/255)
                ], startPoint: .top, endPoint: .bottom))
                .font(Font.system(size: 16, weight: .bold, design: .rounded))
                .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.ratingItem)
                .resizable()
                .scaledToFit()
        )
        .shadow(color: Color.init(red: 255/255, green: 114/255, blue: 221/255, opacity: 0.7), radius: 4, x: 0, y: 0)
        .shadow(color: Color.init(red: 158/255, green: 0/255, blue: 110/255), radius: 0, x: 0, y: 3)
    }
    
    var formattedTime: String {
        let minutes = viewModel.time / 60
        let seconds = viewModel.time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    RecordItemView(viewModel: .init(id: "", level: 1, time: 1, isResolved: true))
}
