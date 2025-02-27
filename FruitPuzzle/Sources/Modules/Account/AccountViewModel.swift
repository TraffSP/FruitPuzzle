//
//  AccountViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import Foundation
import RealmSwift
//import RealmSwift

final class AccountViewModel: ObservableObject {
    @Published var name: String = "ANONYMOUS"
    
    private let storage: MainDomainModelStorage = .init()
    
    init() {
        viewDidLoad()
    }
}

extension AccountViewModel {
    func viewDidLoad() {
//        let accounts = storage.read()
//
//        if let firstAccount = accounts.first {
//            if !firstAccount.name.isEmpty {
//                name = firstAccount.name
//            }
//        }
    }
    
    func updateName(newName: String) {
//        self.name = newName
//
//        let accounts = storage.read()
//        if var firstAccount = accounts.first {
//            firstAccount.name = newName
//            storage.store(item: firstAccount)
//        }
    }
    
    func deleteAccount() {
        storage.deleteAll()
        
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

        if storage.read().isEmpty {
            storage.store(item: .init(title: "anonymous", levels: list))
        }
        
        viewDidLoad()
    }
}
