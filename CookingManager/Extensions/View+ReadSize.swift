//
//  View+ReadSize.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/25.
//

import SwiftUI

extension View {
    func readSize(_ size: Binding<CGSize>) -> some View {
        self
            .background(
                GeometryReader { geometry in
                    Color.clear.onAppear {
                        size.wrappedValue = geometry.size
                    }
                }
            )
    }
}

