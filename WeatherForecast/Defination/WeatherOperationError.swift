//
//  WeatherOperationError.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

enum WeatherOperationError: Error {
    case cityFormatError
    case cityEmpty
    case networkError(error: NetworkError)
    case parseError(error: ParseError)

    var localizedDescription: String {
        switch self {
        case .cityFormatError:
            return "City format is wrong"
        case .cityEmpty:
            return "City can not be empty"
        case .networkError(let err):
            switch err {
            case .cityNotExist:
                return "City not found"
            case .dataEmpty, .others:
                return "Server error, please try again"
            }
        case .parseError(_):
            return "Parser error, please try again"
        }
    }
}
