//
//  CookingSchedule.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/13.
//

import Foundation
import SwiftData

@Model
final class CookingSchedule {
    @Attribute(.unique) var id: UUID
    var recipe: Recipe
    var cookingAt: Date
    var servingSize: Int
    
    init(id: UUID, recipe: Recipe, cookingAt: Date, servingSize: Int) {
        self.id = id
        self.recipe = recipe
        self.cookingAt = cookingAt
        self.servingSize = servingSize
    }
}
