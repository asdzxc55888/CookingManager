//
//  DataProvider.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/29.
//

import SwiftUI
import SwiftData

public typealias CreateDataHandler<T> =  @Sendable () async -> T

public protocol ModelCreatable {
    init(modelContainer: ModelContainer)
}

//MARK: setting DataProvider enviromnent key
public struct DataProviderKey: EnvironmentKey {
    public static let defaultValue: DataProvider = .shared
}

extension EnvironmentValues {
  public var dataProvider: DataProvider {
    get { self[DataProviderKey.self] }
    set { self[DataProviderKey.self] = newValue }
  }
}

//MARK: Handle swiftData modelContainer
public final class DataProvider: Sendable {
    public static let shared = DataProvider()
    
    public init() {}

    public let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self,
            Tag.self,
            Ingredient.self,
            IngredientInfo.self,
            CookingStep.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @MainActor
    public let previewModelContainer: ModelContainer = {
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
    
    private var currentModelContainer: ModelContainer {
        let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        return isPreview ? previewModelContainer : sharedModelContainer
    }
    
    public func dataHandlerCreator<T: ModelCreatable>(for type: T.Type) -> CreateDataHandler<T> {
        let container = currentModelContainer
        return { T(modelContainer: container) }
    }
}
