//
//  MainView.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/19.
//

import SwiftUI

enum MainViewTab: String, Hashable {
    case recipe = "Recipe"
    case cookingSchedule = "CookingSchedule"
}

struct MainView: View {
    @State private var mainRouter: MainRouter = .init(initialRoute: .cookingSchedule)
    
    var body: some View {
        VStack {
            TabView(selection: $mainRouter.currentRoute) {
                ForEach(MainRoute.allCases, id: \.hashValue) { route in
                    mainRouter.view(for: route)
                        .tag(route)
                }
            }
            
            MenuRowView()
        }
        .environment(mainRouter)
    }
}

#Preview {
    MainView()
}
