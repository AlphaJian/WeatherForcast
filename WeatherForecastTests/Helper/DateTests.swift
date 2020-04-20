//
//  DateTests.swift
//  WeatherForecastTests
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

@testable import WeatherForecast
import XCTest

class DateTests: XCTestCase {
    func testGetStringFromTimeStamp() {
        var stamp: Int? = 1587312000 //"2020-04-20 00:00:00"
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2020-04-20")
        
        stamp = 1587398399 //"2020-04-20 23:59:59"
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2020-04-20")
        
        stamp = 1582991999 // "2020-02-29 23:59:59" leap year
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2020-02-29")
        
        stamp = 1582905600 // "2020-02-29 00:00:00"
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2020-02-29")
        
        stamp = nil // ""
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "")
        
        stamp = 1577808000 // "2020-01-01 00:00:00"
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2020-01-01")

        stamp = 1577807999 // "2019-12-31 23:59:59"
        XCTAssertEqual(Date.getStringFromTimeStamp(timeStamp: stamp), "2019-12-31")
    }
}
