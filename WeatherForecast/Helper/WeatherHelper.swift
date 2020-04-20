//
//  WeatherHelper.swift
//  WeatherForecast
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class WeatherHelper {
    static func celsiusToKelvin(temp: Float) -> Float {
        return (temp + 273.15).roundTo(places: 2)
    }
    
    static func celsiusToFahrenheit(temp: Float) -> Float {
        return (temp * 9 / 5 + 32).roundTo(places: 2)
    }
}

extension Float {
    /// Rounds the float to decimal places value, 
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
