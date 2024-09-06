//
//  MainRouter.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/19.
//

import SwiftUI


protocol RouterProtocol {
    associatedtype T: View
    associatedtype RouteType: Hashable
    var currentRoute: RouteType { get set }
    @ViewBuilder func view(for route: RouteType?) -> T
}

@Observable
final class MainRouter: RouterProtocol {
    var currentRoute: MainRoute
    
    init(initialRoute: MainRoute) {
        currentRoute = initialRoute
    }
    
    func replace(_ route: MainRoute) {
        currentRoute = route
    }
    
    @ViewBuilder
    func view(for route: MainRoute? = nil) -> some View {
        let route = route ?? currentRoute
        switch route {
        case .recipeView:
            RecipeListScreen()
        case .cookingSchedule:
            Text("Cooking Schedule")
        case .ingredients:
            Text("Ingredients")
        case .shopping:
            Text("Shopping")
        }
    }
}

enum MainRoute: Hashable, CaseIterable, Equatable {
    case recipeView
    case cookingSchedule
    case ingredients
    case shopping
}
