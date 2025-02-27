//
//  User.swift
//  FruitPuzzle
//
//  Created by muser on 24.02.2025.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
}
