//
//  EditRecipeStepScreenModel.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/3.
//

import Foundation

@Observable
final class EditRecipeStepScreenModel {
    var cookingSteps: [EditCookingStepCell.CookingStep] = [
        .init(textField: CustomTextFieldModel(text: ""))
    ]
    
    var showDeleteButton: Bool {
        cookingSteps.count > 1
    }
    
    func addNewCookingStep() {
        cookingSteps.append(
            .init(textField: .init(text: ""))
        )
    }
    
    func deleteCookingStep(at index: Int) {
        guard index < cookingSteps.count else { return }
        cookingSteps.remove(at: index)
    }
}
