//
//  Business.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/16.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class Business {
    static func requestWeatherByCity(city: String, successHandler: ((WeatherModel) -> Void)?, failHandler: ((Error) -> Void)?) {
        Services.getWeatherByCity(cityName: city).request(successHandler: { (data) in
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                successHandler?(model)
            } catch let err {
                failHandler?(ParseError.decodeError(error: err))
            }
        }) { (error) in
            failHandler?(error)
        }
    }
}
