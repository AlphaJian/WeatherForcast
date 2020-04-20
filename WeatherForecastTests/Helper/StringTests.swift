//
//  StringTests.swift
//  WeatherForecastTests
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

@testable import WeatherForecast
import XCTest

class StringTests: XCTestCase {
    func testIsAlphabetic() {
        var str = ""
        XCTAssertEqual(str.isAlphabetic, false)
        
        str = "shanghai"
        XCTAssertEqual(str.isAlphabetic, true)
        
        str = "shang hai"
        XCTAssertEqual(str.isAlphabetic, true)
        
        str = "Shang Hai"
        XCTAssertEqual(str.isAlphabetic, true)
        
        str = "shanghai1"
        XCTAssertEqual(str.isAlphabetic, false)
        
        str = "上海"
        XCTAssertEqual(str.isAlphabetic, false)
        
        str = "123"
        XCTAssertEqual(str.isAlphabetic, false)
        
        str = "shang_hai"
        XCTAssertEqual(str.isAlphabetic, false)

        str = "shang~hai"
        XCTAssertEqual(str.isAlphabetic, false)
    }
    
    func testNoSpace() {
        XCTAssertEqual(" ".removeSpace(), "")
        XCTAssertEqual(" shanghai".removeSpace(), "shanghai")
        XCTAssertEqual(" shanghai ".removeSpace(), "shanghai")
        XCTAssertEqual(" shang hai ".removeSpace(), "shanghai")
    }
}
