
//
//  Services.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/16.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit
import Alamofire

let Appid = "95d190a434083879a6398aafd54d9e73"

let defaultForecastDayCount = 5
let defaultForecastUnit = "Metric"

enum Services {
    case getWeatherByCity(cityName: String)
    case getWeatherByGPS(lat: Double, lon: Double)

    var baseUrl: String {
        return "http://api.openweathermap.org/data/2.5/"
    }

    var requestMeta: (method: Alamofire.HTTPMethod, path: String) {
        switch self {
        case .getWeatherByCity(let cityName):
            return (.get, "forecast/daily?q=\(cityName)&cnt=\(defaultForecastDayCount)&appid=\(Appid)&units=\(defaultForecastUnit)")
        case .getWeatherByGPS(let lat, let lon):
            return (.get, "forecast/daily?lat=\(lat)&lon=\(lon)&cnt=\(defaultForecastDayCount)&appid=\(Appid)&units=\(defaultForecastUnit)")
        }
    }

    func request(successHandler: ((Data) -> Void)?, failHandler: ((NetworkError) -> Void)?) {
        let url = URL(string: baseUrl + requestMeta.path)

        AF.request(url!, method: requestMeta.0).responseData { (response) in
            print(response)
            guard let data = response.data else {
                failHandler?(.dataEmpty)
                return
            }
            successHandler?(data)
        }
    }
}
