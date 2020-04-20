//
//  NetworkError.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

enum NetworkError: Error {
    case dataEmpty
    case cityNotExist
    case others(err: Error)
}
