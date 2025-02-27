//
//  RecordItemViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation

final class RecordItemViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var level: Int
    @Published var time: Int
    @Published var isResolved: Bool
    
    init(id: String, level: Int, time: Int, isResolved: Bool) {
        self.id = id
        self.level = level
        self.time = time
        self.isResolved = isResolved
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RecordItemViewModel, rhs: RecordItemViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.level == rhs.level &&
            lhs.time == rhs.time &&
            lhs.isResolved == rhs.isResolved
    }
}
