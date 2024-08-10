//
//  Item.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/10.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
