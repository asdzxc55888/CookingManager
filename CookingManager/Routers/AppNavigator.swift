//
//  AppNavigator.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/6.
//

import SwiftUI

struct AppNavigator: View {
    @State private var navigator: Navigator = .init()
    
    var body: some View {
        NavigationStack(path: $navigator.path) {
            MainView()
                .navigationDestination(for: Route.self) { route in
                    route.present
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environment(navigator)
    }
}

@Observable
final class Navigator {
    var path: [Route] = []
    
    func push(route: Route) {
        path.append(route)
    }
    
    func replace(route: Route) {
        guard path.count > 0 else { return }
        
        path[path.count - 1] = route
    }
    
    func pop() {
        path.removeLast()
    }
}

#Preview {
    AppNavigator()
}
