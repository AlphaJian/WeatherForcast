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
    var weatherModel: WeatherModel?

    //MARK: - output
    var errorHandler: ((WeatherOperationError) -> Void)?

    var updateWeather: ((WeatherModel?) -> Void)?

    var showHubHandler: (() -> Void)?
    var hideHubHandler: (() -> Void)?

    //MARK: - input
    func searchCityWeather(city: String?) {
        guard let city = city else {
            errorHandler?(.cityEmpty)
            return 
        }
        let checkResult = checkCityFormat(city: city)
        switch checkResult {
        case .success(let city):
            Business.requestWeatherByCity(city: city, successHandler: updateWeather, failHandler: { [unowned self] (error) in
                self.handleError(error: error)
            })
        case .failure(let error):
            errorHandler?(error)
        }
    }


    //MARK: - private function
    func checkCityFormat(city: String) -> Result<String, WeatherOperationError> {
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


}
