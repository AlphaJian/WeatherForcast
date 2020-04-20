//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class WeatherViewModel {
    //MARK: - property
    private var weatherModel: WeatherModel?
    
    private(set) var weatherUnit: WeatherUnit = .celsius
    
    var weatherForecastCount: Int {
        return weatherModel?.list?.count ?? 0
    }
    
    var weatherForecastDataSource: [WeatherForecastCellModel] {
        guard let list = weatherModel?.list else {
            return []
        }
        return list.compactMap {
            WeatherForecastCellModel(
                dayTime: $0.strDay,
                temperature: "\(getTempFromUnit($0.temp?.day ?? 0))",
                tempMin: "\(getTempFromUnit($0.temp?.min ?? 0))",
                tempMax: "\(getTempFromUnit($0.temp?.max ?? 0))")
        }
    }
    
    var unitSelections = [WeatherUnit.celsius,
                          WeatherUnit.fahrenheit,
                          WeatherUnit.kelvin]

    //MARK: - output
    var errorHandler: ((WeatherOperationError) -> Void)?

    var updateWeather: ((WeatherModel?) -> Void)?

    var showHubHandler: (() -> Void)?
    var hideHubHandler: (() -> Void)?

    //MARK: - input
    func searchCityWeather(city: String?) {
        guard let city = city?.removeSpace() else {
            errorHandler?(.cityEmpty)
            return 
        }
        let checkResult = checkCityFormat(city: city)
        switch checkResult {
        case .success(let city):
            Business.requestWeatherByCity(city: city, successHandler: { [unowned self] (model) in
                self.weatherModel = model
                self.updateWeather?(model)
            }, failHandler: { [unowned self] (error) in
                self.handleError(error: error)
            })
        case .failure(let error):
            errorHandler?(error)
        }
    }
    
    func setWeatherUnit(index: Int) {
        weatherUnit = unitSelections[index]
        updateWeather?(weatherModel)
     }


    //MARK: - private function
    func checkCityFormat(city: String) -> Result<String, WeatherOperationError> {
        if city == "" {
            return .failure(.cityEmpty)
        }
        if city.isAlphabetic {
            return .success(city)
        } else {
            return .failure(.cityFormatError)
        }
    }

    func handleError(error: Error) {
        if let networkError = error as? NetworkError {
            errorHandler?(.networkError(error: networkError))
        } else if let parseError = error as? ParseError {
            errorHandler?(.parseError(error: parseError))
        }
    }
    
    func getTempFromUnit(_ temp: Float) -> Float {
        switch weatherUnit {
        case .celsius:
            return temp
        case .kelvin:
            return WeatherHelper.celsiusToKelvin(temp: temp)
        case .fahrenheit:
            return WeatherHelper.celsiusToFahrenheit(temp: temp)
        }
    }
}
