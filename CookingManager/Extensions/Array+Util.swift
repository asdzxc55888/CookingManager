//
//  Array+Util.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/15.
//

import Foundation

extension Array {
    subscript(bound index: Int) -> Element {
        let loopedIndex = index % self.count
        return self[loopedIndex]
    }
}
