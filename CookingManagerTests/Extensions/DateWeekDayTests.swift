//
//  DateWeekDayTests.swift
//  CookingManagerTests
//
//  Created by 何韋辰 on 2024/8/20.
//

import XCTest
@testable import CookingManager

class DateWeekDayTests: XCTestCase {

    func testGetWeekDay() {

        //MARK: 2024/8/20
        let date = Date(timeIntervalSince1970: 1724149192)
        
        let weekDay = date.getWeekDay()

        XCTAssertEqual(weekDay.count, 7, "Current week should have 7 days")

        let dateStr = weekDay.map { day in
            day.date.toString(dateFormat: "YYYY/MM/dd")
        }
        
        XCTAssertEqual(
            dateStr,
            [
                "2024/08/18",
                "2024/08/19",
                "2024/08/20",
                "2024/08/21",
                "2024/08/22",
                "2024/08/23",
                "2024/08/24",
            ],
            "GetWeekDay Failed"
        )
    }
}
