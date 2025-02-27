//
//  MainDomainModel.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import Foundation
import RealmSwift

struct MainDomainModel {
    var id: UUID
    var title: String
    var levels: List<LevelDomainModel>
    
    init(id: UUID = .init(), title: String = "", levels: List<LevelDomainModel>) {
        self.id = id
        self.title = title
        self.levels = levels
    }
}
