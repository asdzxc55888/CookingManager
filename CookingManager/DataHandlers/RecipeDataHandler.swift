//
//  RecipeDataHandler.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/29.
//

import Foundation
import SwiftUI
import SwiftData

@ModelActor
public actor RecipeDataHandler: ModelCreatable {
    func createRecipe(dto: CreateRecipeDto) throws -> Recipe {
        let recipe = Recipe(
            id: UUID(),
            name: dto.name,
            recipeDesc: dto.recipeDesc,
            cookingTime: dto.cookingTime,
            ingredients: dto.ingredients,
            cookingStep: dto.cookingStep,
            tags: dto.tags,
            category: dto.category
        )
        modelContext.insert(recipe)
        try modelContext.save()
        return recipe
    }
    
    func createTag(tagName: String) throws -> Tag {
        let tag = Tag(name: tagName)
        modelContext.insert(tag)
        try modelContext.save()
        return tag
    }
}

extension RecipeDataHandler {
    struct CreateRecipeDto {
        var name: String
        var recipeDesc: String
        var cookingTime: TimeInterval
        var ingredients: [IngredientInfo]
        var cookingStep: [CookingStep]
        var tags: [Tag]
        var category: RecipeCategory
    }
}
