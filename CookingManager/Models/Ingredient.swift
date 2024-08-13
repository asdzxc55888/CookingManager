//
//  Ingredient.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/13.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    @Attribute(.unique) var id: UUID
    var name: String
    var quantifier: String
    // MARK: If have simple enough option, then didn't need to care about the number
    var isSimpleEnough: Bool?
    
    init(id: UUID, name: String, quantifier: String) {
        self.id = id
        self.name = name
        self.quantifier = quantifier
    }
}
