//
//  RecordViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation

final class RecordViewModel: ObservableObject {
    @Published var items: [RecordItemViewModel]
    
    init(items: [RecordItemViewModel]) {
        self.items = items
    }
    
//    func reloadData() {
//        let gameStorage: GameDomainModelStorage = .init()
////        let newItems = gameStorage.read().compactMap({ makeCellViewModel(for: $0) })
//
//        let levelItems: [LevelItemViewModel] = gameStorage.read().first?.puzzles
//            .compactMap { makeCellViewModel(for: $0) } ?? []
//
////        return levelItems
//
//        items = levelItems
//    }
    
//    func makeCellViewModel(
//        for model: PuzzleDomainModel
//    ) -> LevelItemViewModel? {
//        return .init(
//            id: model.id.uuidString,
//            image: model.image,
//            cellsCount: model.cellsCount,
//            isResolved: model.isResolved
//        )
//    }
}
