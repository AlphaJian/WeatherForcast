//
//  WLabel.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/16.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class WLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor.black
        font = UIFont.systemFont(ofSize: 14)
        textAlignment = .left
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
