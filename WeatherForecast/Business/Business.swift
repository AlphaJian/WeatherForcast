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
            let result = handleServerError(response: data)
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                    successHandler?(model)
                } catch let err {
                    failHandler?(ParseError.decodeError(error: err))
                }
            case .failure(let error):
                failHandler?(error)
            }

        }) { (error) in
            failHandler?(error)
        }
    }
    
    private static func handleServerError(response: Data?) -> Result<Data, NetworkError> {
        guard let data = response else {
            return .failure(.dataEmpty)
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject?] else {
            return .failure(.dataEmpty)
        }
        if let code = json["cod"] as? String, code == "404" {
            return .failure(.cityNotExist)
        }
        return .success(data)
    }
}
