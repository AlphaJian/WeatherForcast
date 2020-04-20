//
//  WeatherEnum.swift
//  WeatherForecast
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

enum WeatherUnit: String {
    case kelvin = "Kelvin"
    case celsius = "Celsuis"
    case fahrenheit = "Fahrenheit"
    
    var desc: String {
        return self.rawValue
    }
    
    var unit: String {
        switch self {
        case .kelvin:
            return "K"
        case .celsius:
            return "℃"
        case .fahrenheit:
            return "℉"
        }
    }
}
