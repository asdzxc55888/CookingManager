//
//  CookingManagerApp.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/10.
//

import SwiftUI
import SwiftData

@main
struct CookingManagerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppNavigator()
        }
    }
}
