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
        let startDate = calendar.startOfDay(for: date)
        
        //var weekDay: [WeekDay] = []
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
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
