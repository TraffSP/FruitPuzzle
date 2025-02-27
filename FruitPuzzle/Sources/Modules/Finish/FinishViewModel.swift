//
//  FinishViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 23.02.2025.
//

import Foundation

final class FinishViewModel: ObservableObject {
    @Published var time: String
    
    init(time: String) {
        self.time = time
    }
}
