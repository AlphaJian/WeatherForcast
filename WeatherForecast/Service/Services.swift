
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

enum Services {
    case getWeatherByCity(cityName: String)

    var baseUrl: String {
        return "http://api.openweathermap.org/data/2.5/"
    }

    var requestMeta: (method: Alamofire.HTTPMethod, path: String) {
        switch self {
        case .getWeatherByCity(let cityName):
            return (.get, "forecast/daily?q=\(cityName)&cnt=5&appid=\(Appid)&units=Metric")
        }
    }

    func request() {
        let url = URL(string: baseUrl + requestMeta.path)

        AF.request(url!, method: requestMeta.0).responseData { (response) in
            print(response)
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: response.data!)
                print(model)
            } catch let err {
                print(err)
            }
        }
    }
}
