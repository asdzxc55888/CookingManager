//
//  Route.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/6.
//

import SwiftUI

enum Route: Hashable {
    case main
    case createRecipe(onBack: () -> Void)
    
    @ViewBuilder
    var present: some View {
        switch self {
        case .main:
            MainView()
        case .createRecipe(let onBack):
            CreateRecipeScreen(onBack: onBack)
        }
    }
    
    var id: String {
        switch self {
        case .main:
            return "Main"
        case .createRecipe:
            return "CreateRecipe"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.id == rhs.id
    }
}
