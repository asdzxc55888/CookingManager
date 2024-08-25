//
//  TimeInterval+Utils.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/25.
//

import Foundation


extension TimeInterval {
    func toHoursAndMinutes() -> (hours: Int, minutes: Int) {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        return (hours, minutes)
    }
}
