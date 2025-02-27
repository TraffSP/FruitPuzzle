//
//  RealmDomainModel.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var name: String = ""
    @Persisted var levels: List<LevelDomainModel>
        
    convenience init(
        id: UUID = .init(),
        name: String,
        levels: List<LevelDomainModel>
    ) {
        self.init()
        self.id = id
        self.name = name
        self.levels = levels
    }
}
