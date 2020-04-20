//
//  WeatherForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by 张坚 on 2020/4/19.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherForecastTableViewCell"
    
    lazy var dayTimeLabel = WLabel(frame: CGRect.zero)
    
    lazy var tempLabel = WLabel(frame: CGRect.zero)
    lazy var tempMinLabel = WLabel(frame: CGRect.zero)
    lazy var tempMaxLabel = WLabel(frame: CGRect.zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dayTimeLabel)
        dayTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dayTimeLabel.snp.trailing)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(tempMinLabel)
        tempMinLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tempLabel.snp.trailing)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(tempMaxLabel)
        tempMaxLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tempMinLabel.snp.trailing)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: WeatherForecastCellModel) {
        dayTimeLabel.text = model.dayTime
        tempLabel.text = model.temperature
        tempMinLabel.text = model.tempMin
        tempMaxLabel.text = model.tempMax
    }
}
