//
//  LevelListingViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation

final class LevelListingViewModel: ObservableObject {
    @Published var items: [LevelViewModel]
    
    init(items: [LevelViewModel]) {
        self.items = items
    }
    
    func reloadData() {
        let gameStorage: MainDomainModelStorage = .init()
        
        let levelItems: [LevelViewModel] = gameStorage.read().first?.levels
            .compactMap { makeLevelsCellViewModel(for: $0) } ?? []
        
        items = levelItems
    }
    
    func makeLevelsCellViewModel(
        for model: LevelDomainModel
    ) -> LevelViewModel? {
        return .init(id: model.id.uuidString, level: model.level, isResolved: model.isResolved)
    }
}
