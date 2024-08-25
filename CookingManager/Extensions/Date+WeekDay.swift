//
//  Date+WeekDay.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/20.
//

import SwiftUI

extension Date {
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
    //MARK: Get the weekday of the current date
    func getWeekDay() -> [WeekDay] {
        let date = self
        let calendar = Calendar.current
        
        guard let weekRange = calendar.range(of: .day, in: .weekOfMonth, for: date) else {
            return []
        }
        guard let startOfWeek = calendar.date(byAdding: .day, value: weekRange.lowerBound - date.get(.day), to: date) else {
            return []
        }
        
        return (0..<7).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) {
                return .init(date: date)
            } else {
                return nil
            }
        }
    }
    
    static func getWeekDateRange(forWeek weekOfYear: Int, inYear year: Int) -> [WeekDay] {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.weekOfYear = weekOfYear
        components.yearForWeekOfYear = year
        
        if let startOfWeek = calendar.date(from: components) {
            return startOfWeek.getWeekDay()
        }
        
        return []
    }
}
