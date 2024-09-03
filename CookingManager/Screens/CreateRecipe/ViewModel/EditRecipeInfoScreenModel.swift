//
//  EditRecipeInfoScreenModel.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/3.
//

import Foundation

@Observable
final class EditRecipeInfoScreenModel {
    var name: String
    var description: String
    var cookingTime: TimeInterval
    var category: RecipeCategory?
    var tags: [Tag] = []
    
    //MARK: error state
    var isNameError: Bool = false
    var isDescriptionError: Bool = false
    var isCategoryError: Bool = false

    init(
        name: String = "",
        description: String = "",
        cookingTime: TimeInterval = 60,
        category: RecipeCategory? = nil,
        tags: [Tag] = []
    ) {
        self.name = name
        self.description = description
        self.cookingTime = cookingTime
        self.category = category
        self.tags = tags
    }

    var isDone: Bool {
        !(name.isEmpty || category == nil || cookingTime == 0)
    }
    
    func addTags(tagText: String, tags: [Tag], dataHandler: RecipeDataHandler) async throws {
        guard !tagText.isEmpty else { return }
        guard !self.tags.contains(where: { $0.name == tagText }) else { return }
        
        if let tag = tags.first(where: { $0.name == tagText }) {
            self.tags.append(tag)
        } else {
            let newTag = try await dataHandler.createTag(tagName: tagText)
            self.tags.append(newTag)
        }
    }
}
