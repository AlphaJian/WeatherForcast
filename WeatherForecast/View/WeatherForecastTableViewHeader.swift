//
//  WeatherForecastTableViewHeader.swift
//  WeatherForecast
//
//  Created by 张坚 on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

let dayWidth: CGFloat = 120.0
let tempWidth = (UIScreen.main.bounds.size.width - dayWidth) / 3

class WeatherForecastTableViewHeader: UIView {

    lazy var dayLabel: WLabel = {
        let lbl = WLabel(frame: CGRect.zero)
        lbl.text = "Day"
        return lbl
    }()
    lazy var tempLabel: WLabel = {
        let lbl = WLabel(frame: CGRect.zero)
        lbl.text = "Temp"
        return lbl
    }()
    lazy var minTempLabel: WLabel = {
        let lbl = WLabel(frame: CGRect.zero)
        lbl.text = "Min"
        return lbl
    }()
    lazy var maxTempLabel: WLabel = {
        let lbl = WLabel(frame: CGRect.zero)
        lbl.text = "Max"
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(dayWidth)
        }
        
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(dayLabel.snp.trailing)
            make.width.equalTo(tempWidth)
        }
        
        addSubview(minTempLabel)
        minTempLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(tempLabel.snp.trailing)
            make.width.equalTo(tempWidth)
        }
        
        addSubview(maxTempLabel)
        maxTempLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(minTempLabel.snp.trailing)
            make.width.equalTo(tempWidth)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUnit(unit: String) {
        tempLabel.text = (tempLabel.text ?? "") + "(\(unit))"
        minTempLabel.text = (minTempLabel.text ?? "") + "(\(unit))"
        maxTempLabel.text = (maxTempLabel.text ?? "") + "(\(unit))"
    }
}
