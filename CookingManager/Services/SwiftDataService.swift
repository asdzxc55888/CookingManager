//
//  SwiftDataService.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/15.
//

import Foundation
import SwiftData

protocol SwiftDataServiceProtocol {
    func getModelContext() -> ModelContext
}

@MainActor
class ModelContainerService {
    static let previewModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self,
            Tag.self,
            Ingredient.self,
            IngredientInfo.self,
            CookingStep.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            container.mainContext.insert(Recipe.mock)
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

class SwiftDataPreviewService: SwiftDataServiceProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataPreviewService()
    
    @MainActor
    init() {
        self.modelContainer = {
            let schema = Schema([
                Recipe.self,
                Tag.self,
                Ingredient.self,
                IngredientInfo.self,
                CookingStep.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            do {
                let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
                
                container.mainContext.insert(Recipe.mock)
                
                return container
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchRecipes() -> [Recipe] {
        do {
            return try modelContext.fetch(FetchDescriptor<Recipe>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getModelContext() -> ModelContext {
        modelContext
    }
}
