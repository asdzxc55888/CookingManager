//
//  Recipe.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/13.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var id: UUID
    var name: String
    var recipeDesc: String
    var cookingTime: TimeInterval
    var ingredients: [IngredientInfo]
    var cookingStep: [CookingStep]
    var tags: [Tag]
    var category: RecipeCategory
    @Attribute(.externalStorage) var previewImage: Data?
    
    init(id: UUID, name: String, recipeDesc: String, cookingTime: TimeInterval, previewImage: Data? = nil, ingredients: [IngredientInfo], cookingStep: [CookingStep], tags: [Tag], category: RecipeCategory) {
        self.id = id
        self.name = name
        self.recipeDesc = recipeDesc
        self.cookingTime = cookingTime
        self.ingredients = ingredients
        self.cookingStep = cookingStep
        self.tags = tags
        self.category = category
        self.previewImage = previewImage
    }
    
    static let mock: Recipe = .init(
        id: UUID(uuidString: "ebd50a26-89a3-48df-a12f-6e1f3054a85d")!,
        name: "空心菜炒豬肉",
        recipeDesc: "這是一個好吃的料理",
        cookingTime: 60 * 20,
        previewImage: loadImageData(name: "SampleRecipeImage_1", withExtension: "png"),
        ingredients: [],
        cookingStep: [],
        tags: [
            .init(name: "簡單"),
            .init(name: "台式")
        ],
        category: .mainCourse
    )
}

@Model
final class CookingStep {
    var text: String
    @Attribute(.externalStorage) var image: Data?
    
    init(text: String, image: Data? = nil) {
        self.text = text
        self.image = image
    }
}

@Model
final class IngredientInfo {
    var ingredient: Ingredient
    var number: Int
    
    init(ingredient: Ingredient, number: Int) {
        self.ingredient = ingredient
        self.number = number
    }
    
    var isValid: Bool {
        !ingredient.name.isEmpty &&
        !ingredient.quantifier.isEmpty &&
        number != 0
    }
}

enum RecipeCategory: String, CaseIterable, Identifiable, Codable {
    case mainCourse = "主菜"
    case sideDish = "配菜"
    case dessert = "甜點"
    case beverage = "飲料"
    case breakfast = "早餐"
    case snack = "小吃"
    case soup = "湯類"
    case pastaAndRice = "麵飯類"
    case salad = "沙拉"
    case vegetarian = "素食"
    
    var id: String { self.rawValue }
}


