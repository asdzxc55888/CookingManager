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
    var ingredients: [IngredientInfo]
    var cookingStep: [CookingStep]
    var tags: [Tag]
    var category: RecipeCategory
    @Attribute(.externalStorage) var previewImage: Data?
    
    init(id: UUID, name: String, previewImage: Data? = nil, ingredients: [IngredientInfo], cookingStep: [CookingStep], tags: [Tag], category: RecipeCategory) {
        self.id = id
        self.name = name
        self.previewImage = previewImage
        self.ingredients = ingredients
        self.cookingStep = cookingStep
        self.tags = tags
        self.category = category
    }
}

@Model
final class CookingStep {
    var illustration: String
    @Attribute(.externalStorage) var image: Data?
    
    init(illustration: String, image: Data? = nil) {
        self.illustration = illustration
        self.image = image
    }
}

struct IngredientInfo {
    var ingredient: Ingredient
    var number: Int
}

enum RecipeCategory: String, CaseIterable, Identifiable {
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


