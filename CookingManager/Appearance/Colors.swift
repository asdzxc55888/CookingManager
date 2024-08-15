//
//  Colors.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/15.
//

import Foundation
import SwiftUI

enum RecipeCardColor: CaseIterable {
    case green
    case blue
    case indigo
    case pink
    case earth
    
    var color: Color {
        switch self {
        case .green:
            return .init(hex: "B0F2B4")
        case .blue:
            return .init(hex: "BAF2E9")
        case .indigo:
            return .init(hex: "BAD7F2")
        case .pink:
            return .init(hex: "F2BAC9")
        case .earth:
            return .init(hex: "F2E2BA")
        }
    }
}

#Preview {
    VStack {
        let lazyVGridColumns = Array.init(repeating: GridItem(.fixed(80)), count: 5)
        Text("RecipeCardColor")
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVGrid(columns: lazyVGridColumns, spacing: 0) {
                ForEach(RecipeCardColor.allCases, id: \.hashValue) { color in
                    Rectangle()
                        .fill(color.color)
                        .frame(width: 80, height: 80)
                }
            }
        }
    }
}
