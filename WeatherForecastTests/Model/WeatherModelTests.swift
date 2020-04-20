//
//  WeatherModelTests.swift
//  WeatherForecastTests
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

@testable import WeatherForecast
import XCTest

func dataWithJson(_ name: String) -> Data {
    let path = Bundle(for: WeatherForecastTests.self).url(forResource: name, withExtension: "json")!
    let data = try! Data(contentsOf: path)
    return data
}

class WeatherModelTests: XCTestCase {
    private var data: Data!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        data = dataWithJson("weather")
    }

    func test() {
        if let model = try? JSONDecoder().decode(WeatherModel.self, from: data) {
            XCTAssertEqual(model.city!.name, "shanghai")

            XCTAssertEqual(model.list!.count, 5)
            XCTAssertEqual(model.list![0].dayTime, 1587265200)
            XCTAssertEqual(model.list![0].temp!.day, 15.65)
            XCTAssertEqual(model.list![0].temp!.min, 13.79)
            XCTAssertEqual(model.list![0].temp!.max, 17.74)
            XCTAssertEqual(model.list![0].strDay, "2020-04-19")

            XCTAssertEqual(model.list![1].dayTime, 1587351600)
            XCTAssertEqual(model.list![1].temp!.day, 18.99)
            XCTAssertEqual(model.list![1].temp!.min, 12.54)
            XCTAssertEqual(model.list![1].temp!.max, 20.81)
            XCTAssertEqual(model.list![1].strDay, "2020-04-20")

            XCTAssertEqual(model.list![2].dayTime, 1587438000)
            XCTAssertEqual(model.list![2].temp!.day, 14.5)
            XCTAssertEqual(model.list![2].temp!.min, 11.74)
            XCTAssertEqual(model.list![2].temp!.max, 15.09)
            XCTAssertEqual(model.list![2].strDay, "2020-04-21")

            XCTAssertEqual(model.list![3].dayTime, 1587524400)
            XCTAssertEqual(model.list![3].temp!.day, 16.63)
            XCTAssertEqual(model.list![3].temp!.min, 11)
            XCTAssertEqual(model.list![3].temp!.max, 17.89)
            XCTAssertEqual(model.list![3].strDay, "2020-04-22")

            XCTAssertEqual(model.list![4].dayTime, 1587610800)
            XCTAssertEqual(model.list![4].temp!.day, 16.37)
            XCTAssertEqual(model.list![4].temp!.min, 11.22)
            XCTAssertEqual(model.list![4].temp!.max, 17.64)
            XCTAssertEqual(model.list![4].strDay, "2020-04-23")

        }
    }
}
