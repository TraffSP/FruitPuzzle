//
//  LevelViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation

final class LevelViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var level: Int
    @Published var isResolved: Bool
    
    init(id: String, level: Int, isResolved: Bool) {
        self.id = id
        self.level = level
        self.isResolved = isResolved
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LevelViewModel, rhs: LevelViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.level == rhs.level &&
            lhs.isResolved == rhs.isResolved
    }
}
