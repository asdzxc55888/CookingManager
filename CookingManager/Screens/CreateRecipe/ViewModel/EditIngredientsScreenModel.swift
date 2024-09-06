//
//  EditIngredientsScreenModel.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/5.
//

import Foundation

@Observable
final class EditIngredientsScreenModel {
    struct IngredientProps: Equatable, Identifiable {
        let id: UUID = .init()
        var ingredientName: CustomTextFieldModel
        var ingredientQuantifier: CustomTextFieldModel
        var number: Int
        
        static func == (
            lhs: EditIngredientsScreenModel.IngredientProps,
            rhs: EditIngredientsScreenModel.IngredientProps
        ) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    var ingredients: [IngredientProps] = []
    
    func addIngredients() {
        ingredients.append(
            .init(
                ingredientName: .init(
                    text: "",
                    placeholder: "食譜名稱",
                    validation: EditIngredientsScreenModel.ingredientNameValidation
                ),
                ingredientQuantifier: .init(
                    text: "",
                    placeholder: "單位",
                    validation: EditIngredientsScreenModel.ingredientQuantifierValidation
                ),
                number: 0
            )
        )
    }
    
    func validate() -> Bool {
        var isValid = true
        ingredients.forEach { ingredient in
            isValid = ingredient.ingredientName.validate() && isValid
            isValid = ingredient.ingredientQuantifier.validate() && isValid
        }
        return isValid
    }
    
    private static func ingredientNameValidation(_ text: String) -> String? {
        if text.isEmpty {
            return "請輸入食譜名稱"
        }
        return nil
    }
    
    private static func ingredientQuantifierValidation(_ text: String) -> String? {
        if text.isEmpty {
            return "請輸入單位"
        }
        return nil
    }
}
