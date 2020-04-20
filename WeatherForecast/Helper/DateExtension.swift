//
//  DateExtension.swift
//  WeatherForecast
//
//  Created by 张坚 on 2020/4/19.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

let normalDateFormat = "yyyy-MM-dd"

extension Date {
    static func getStringFromTimeStamp(timeStamp: Int?) -> String {
        guard let timeStamp = timeStamp else {
            return ""
        }
        let timeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = normalDateFormat
        return dateFormatter.string(from: date)
    }
}
