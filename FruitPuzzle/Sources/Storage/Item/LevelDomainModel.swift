//
//  LevelDomainModel.swift
//  FruitPuzzle
//
//  Created by muser on 25.02.2025.
//

import Foundation
import RealmSwift

final class LevelDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var level: Int = 0
    @Persisted var isResolved: Bool = false
    @Persisted var time: Int = 0
        
    convenience init(
        id: UUID = .init(),
        level: Int,
        isResolved: Bool,
        time: Int
    ) {
        self.init()
        self.id = id
        self.level = level
        self.isResolved = isResolved
        self.time = time
    }
}
