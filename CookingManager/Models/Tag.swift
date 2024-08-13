//
//  Tag.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/13.
//

import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}
