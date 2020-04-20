//
//  StringExtension.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

extension String {
    var isAlphabetic: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
