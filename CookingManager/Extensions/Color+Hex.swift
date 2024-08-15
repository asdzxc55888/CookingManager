//
//  Color+Hex.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/15.
//

import SwiftUI

extension Color {
    // MARK: Color(hex: "FFFFFF")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted).uppercased()
        
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let red, green, blue: Double
        switch hex.count {
        case 6: // #RRGGBB
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
        default:
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        
        self.init(red: red, green: green, blue: blue)
    }
}
