//
//  TagView.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/27.
//

import SwiftUI

struct TagView: View {
    let tag: Tag
    
    var body: some View {
        Text(tag.name)
            .font(.system(size: 12))
            .foregroundStyle(Color.white)
            .padding(.vertical, Spacing.xs)
            .padding(.horizontal, Spacing.m)
            .background {
                RoundedRectangle(cornerRadius: 12)
            }
    }
}
