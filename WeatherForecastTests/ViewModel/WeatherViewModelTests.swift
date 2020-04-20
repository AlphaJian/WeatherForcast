//
//  WeatherViewModelTests.swift
//  WeatherForecastTests
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

@testable import WeatherForecast
import XCTest

class WeatherViewModelTests: XCTestCase {
    
    let viewModel = WeatherViewModel()
    
    func testCheckCityFormat() {
        var cityName = "shanghai"
        var result = viewModel.checkCityFormat(city: cityName)
        switch result {
        case .success(let city):
            XCTAssertEqual(city, cityName)
        case .failure(_):
            break
        }
        
        cityName = ""
        result = viewModel.checkCityFormat(city: cityName)
        switch result {
        case .success(_):
            break
        case .failure(let error):
            switch error {
            case .cityEmpty:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
        }
        
        cityName = "shang_hai"
        result = viewModel.checkCityFormat(city: cityName)
        switch result {
        case .success(_):
            break
        case .failure(let error):
            switch error {
            case .cityFormatError:
                XCTAssert(true)
            default:
                XCTFail()
            }
        }
    }
    
    func testGetTempFromUnit() {
        // mock unit as celsius
        viewModel.setWeatherUnit(index: 0)
        
        var temp: Float = -100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), -100)
        temp = 0
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 0)
        temp = 100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 100)
        
        // mock unit as fahrenheit
        viewModel.setWeatherUnit(index: 1)
        temp = -100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), -148)
        temp = 0
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 32)
        temp = 100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 212)
        
        // mock unit as kelvin
        viewModel.setWeatherUnit(index: 2)
        temp = -100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 173.15)
        temp = 0
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 273.15)
        temp = 100
        XCTAssertEqual(viewModel.getTempFromUnit(temp), 373.15)
    }
    
    func testSearchShanghai() {
        //  observer callback to see if result is right
        viewModel.updateWeather = { (model) in
            XCTAssertEqual(model?.city?.name, "shanghai")
            model?.list?.forEach({ (item) in
                //  the max temp in shanghai definitly won't bigger than 45℃, and smaller than -10℃
                XCTAssertGreaterThan(item.temp!.min!, -10.0)
                XCTAssertLessThan(item.temp!.max!, 45)

            })
        }
        
        viewModel.errorHandler = { (_) in
            XCTFail()
        }
        
        viewModel.searchCityWeather(city: "shanghai")
    }
    
    func testSearchCityNotExists() {
        viewModel.errorHandler = { (error) in
            switch error {
            case .networkError(let networkErr):
                if case NetworkError.cityNotExist = networkErr {
                    XCTAssert(true)
                } else {
                    XCTFail()
                }
            default:
                XCTFail()
            }
            
        }
        
        viewModel.searchCityWeather(city: "abc")
    }
}
