//
//  MainDomainModelStorage.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import Foundation
import RealmSwift

final class MainDomainModelStorage {
    let storage: RealmStorage = .shared
    
    func store(item: MainDomainModel) {
        storage.create(object: transformToDBO(domainModel: item))
    }
    
    func read() -> [MainDomainModel] {
        guard let results = storage.read(type: RealmDomainModel.self) else {
            return []
        }
    
        return results
            .compactMap(transformToDomainModel)
    }
        
    func delete(ids: [UUID]) {
        storage.delete(type: RealmDomainModel.self, where: { $0.id.in(ids) })
    }
    
    func deleteAll() {
        guard let results = storage.read(type: RealmDomainModel.self) else { return }
        storage.delete(objects: Array(results))
    }
}

private extension MainDomainModelStorage {
    func transformToDBO(domainModel model: MainDomainModel) -> RealmDomainModel {
        return .init(id: model.id, name: model.title, levels: model.levels)
    }
    
    func transformToDomainModel(model: RealmDomainModel) -> MainDomainModel? {
        return .init(id: model.id, title: model.name, levels: model.levels)
    }
}
