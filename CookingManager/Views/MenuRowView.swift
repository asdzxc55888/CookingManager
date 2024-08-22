//
//  MenuRowView.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/19.
//

import SwiftUI

struct MenuRowView: View {
    @Environment(MainRouter.self) var mainRouter
    @State private var selectedButton: MenuButton = .cookingSchedule
    @Namespace var selectedAnimation
    
    var body: some View {
        HStack {
            ForEach(MenuButton.allCases, id: \.hashValue) { menuButton in
                Spacer()
                makeMenuButton(menuButton: menuButton)
                Spacer()
            }
        }
        .padding(.vertical, Spacing.s)
        .padding(.horizontal, Spacing.xl)
        .background(CustomColor.skyBule)
    }
    
    @ViewBuilder
    private func makeMenuButton(menuButton: MenuButton) -> some View {
        Button(
            action: { navigate(menuButton: menuButton) },
            label: {
                VStack(spacing: Spacing.xxs) {
                    Image(systemName: menuButton.icon)
                        .imageScale(.small)
                        .font(.system(size: 28))
                    Text(menuButton.name)
                        .font(.system(size: 12))
                    
                    if selectedButton == menuButton {
                        Rectangle()
                            .frame(width: 80, height: 1)
                            .foregroundStyle(Color.white.opacity(0.75))
                            .matchedGeometryEffect(id: "Bar", in: selectedAnimation)
                    }
                }
                .frame(width: 80, height: 48)
                .foregroundStyle(Color.white)
                .animation(.easeInOut, value: selectedButton)
            }
        )
    }
}

//MARK: Handler
extension MenuRowView {
    //TODO: navigate to right screen
    private func navigate(menuButton: MenuButton) {
        selectedButton = menuButton
        mainRouter.replace(menuButton.mainRoute)
    }
}

//MARK: MenuButton
extension MenuRowView {
    enum MenuButton: CaseIterable {
        case recipe
        case cookingSchedule
        case ingredient
        case doShopping
        
        var icon: String {
            switch self {
            case .recipe: return "fork.knife"
            case .cookingSchedule: return "calendar.badge.clock"
            case .ingredient: return "basket.fill"
            case .doShopping: return "cart.fill"
            }
        }
        
        var name: String {
            switch self {
            case .recipe: return "食譜"
            case .cookingSchedule: return "烹飪排程"
            case .ingredient: return "食材"
            case .doShopping: return "採買"
            }
        }
        
        var mainRoute: MainRoute {
            switch self {
            case .recipe: return .recipeView
            case .cookingSchedule: return .cookingSchedule
            case .ingredient: return .ingredients
            case .doShopping: return .shopping
            }
        }
    }
}

#Preview {
    MenuRowView()
        .environment(MainRouter(initialRoute: .cookingSchedule))
}
