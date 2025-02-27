//
//  MainViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation
import RealmSwift

final class MainViewModel: ObservableObject {
    
    func viewDidLoad() {
        let gameStorage: MainDomainModelStorage = .init()
        
        guard gameStorage.read().isEmpty else { return }
        
        let list = List<LevelDomainModel>()
        
        list.append(.init(level: 1, isResolved: true, time: 0))
        list.append(.init(level: 2, isResolved: false, time: 0))
        list.append(.init(level: 3, isResolved: false, time: 0))
        list.append(.init(level: 4, isResolved: false, time: 0))
        list.append(.init(level: 5, isResolved: false, time: 0))
        list.append(.init(level: 6, isResolved: false, time: 0))
        list.append(.init(level: 7, isResolved: false, time: 0))
        list.append(.init(level: 8, isResolved: false, time: 0))
        list.append(.init(level: 9, isResolved: false, time: 0))
        list.append(.init(level: 10, isResolved: false, time: 0))
        list.append(.init(level: 11, isResolved: false, time: 0))
        list.append(.init(level: 12, isResolved: false, time: 0))
        list.append(.init(level: 13, isResolved: false, time: 0))
        list.append(.init(level: 14, isResolved: false, time: 0))
        list.append(.init(level: 15, isResolved: false, time: 0))
        list.append(.init(level: 16, isResolved: false, time: 0))

        gameStorage.store(item: .init(title: "anonymous", levels: list))
    }
    
    func loadlevelsData() -> [LevelViewModel] {
        let gameStorage: MainDomainModelStorage = .init()
        
        let levelItems: [LevelViewModel] = gameStorage.read().first?.levels
            .compactMap { makeLevelsCellViewModel(for: $0) } ?? []
        
        return levelItems
    }
    
    func makeLevelsCellViewModel(
        for model: LevelDomainModel
    ) -> LevelViewModel? {
        return .init(id: model.id.uuidString, level: model.level, isResolved: model.isResolved)
    }
    
    func loadRatingData() -> [RecordItemViewModel] {
        let gameStorage: MainDomainModelStorage = .init()
        
        let levelItems: [RecordItemViewModel] = gameStorage.read().first?.levels
            .compactMap { makeRatingCellViewModel(for: $0) } ?? []
        
        return levelItems
    }
    
    func makeRatingCellViewModel(
        for model: LevelDomainModel
    ) -> RecordItemViewModel? {
        return .init(id: model.id.uuidString, level: model.level, time: model.time, isResolved: model.isResolved)
    }
}
