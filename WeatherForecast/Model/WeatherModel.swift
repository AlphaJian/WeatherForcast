//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/16.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

struct WeatherModel: Codable {
    var list: [WeatherItem]?
}

struct WeatherItem: Codable {
    var dayTime: Int?
    var temp: WeatherTemp?
    
    enum CodingKeys: String, CodingKey {
        case dayTime = "dt"
        case temp = "temp"
    }
}

struct WeatherTemp: Codable {
    var day: Float?
}