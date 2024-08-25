//
//  TimeIntervalExtensionTests.swift
//  CookingManagerTests
//
//  Created by 何韋辰 on 2024/8/25.
//

import XCTest
@testable import CookingManager

class TimeIntervalExtensionTests: XCTestCase {

    func testToHoursAndMinutes() {
        // 測試 0 秒
        var timeInterval: TimeInterval = 0
        var result = timeInterval.toHoursAndMinutes()
        XCTAssertEqual(result.hours, 0)
        XCTAssertEqual(result.minutes, 0)

        // 測試 3600 秒（1 小時）
        timeInterval = 3600
        result = timeInterval.toHoursAndMinutes()
        XCTAssertEqual(result.hours, 1)
        XCTAssertEqual(result.minutes, 0)

        // 測試 3661 秒（1 小時 1 分鐘）
        timeInterval = 3661
        result = timeInterval.toHoursAndMinutes()
        XCTAssertEqual(result.hours, 1)
        XCTAssertEqual(result.minutes, 1)

        // 測試 86399 秒（23 小時 59 分鐘）
        timeInterval = 86399
        result = timeInterval.toHoursAndMinutes()
        XCTAssertEqual(result.hours, 23)
        XCTAssertEqual(result.minutes, 59)
    }
}

