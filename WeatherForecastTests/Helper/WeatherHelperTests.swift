//
//  WeatherHelperTests.swift
//  WeatherForecastTests
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

@testable import WeatherForecast
import XCTest

class WeatherHelperTests: XCTestCase {
    func testCelsiusToKelvin() {
        var temp: Float = -100
        XCTAssertEqual(WeatherHelper.celsiusToFahrenheit(temp: temp), -148)
        XCTAssertEqual(WeatherHelper.celsiusToKelvin(temp: temp), 173.15)
        
        temp = 0
        XCTAssertEqual(WeatherHelper.celsiusToFahrenheit(temp: temp), 32)
        XCTAssertEqual(WeatherHelper.celsiusToKelvin(temp: temp), 273.15)
        
        temp = 100
        XCTAssertEqual(WeatherHelper.celsiusToFahrenheit(temp: temp), 212)
        XCTAssertEqual(WeatherHelper.celsiusToKelvin(temp: temp), 373.15)
        
        temp = 100.32
        XCTAssertEqual(WeatherHelper.celsiusToFahrenheit(temp: temp), 212.58)
        XCTAssertEqual(WeatherHelper.celsiusToKelvin(temp: temp), 373.47)
        
        temp = 100.28
        XCTAssertEqual(WeatherHelper.celsiusToFahrenheit(temp: temp), 212.50)
        XCTAssertEqual(WeatherHelper.celsiusToKelvin(temp: temp), 373.43)
    }
}
