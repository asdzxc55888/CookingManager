//
//  View+RoundCorner.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/17.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var cornerns: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: cornerns, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, cornerns: corners))
    }
}
