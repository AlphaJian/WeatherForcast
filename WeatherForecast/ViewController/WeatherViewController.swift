//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/16.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift

class WeatherViewController: UIViewController {
    //MARK: - Defination

    let padding = 20

    //MARK: - UI Elements
    lazy var cityLabel: WLabel = {
        let lbl = WLabel(frame: CGRect.zero)
        lbl.text = "Please input your city name:"

        return lbl
    }()

    lazy var cityTextField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        textField.placeholder = "city name"
        textField.borderStyle = .line
        return textField
    }()

    lazy var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)

        return btn
    }()

    lazy var weatherTableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)

        return tb
    }()

    //MARK: - Property
    var viewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutUI()

        viewModel = WeatherViewModel()

        LocationManager.shared.startPositioning()
        LocationManager.shared.locationHandler = { (location) in
            
        }

        bindOutput()

    }

    //MARK: - init methods
    func layoutUI() {
        view.backgroundColor = UIColor.white

        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(100)
        }

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(cityLabel.snp.trailing)
            make.top.equalTo(cityLabel.snp.bottom).offset(padding)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)

        view.addSubview(cityTextField)
        cityTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(cityLabel.snp.leading)
            make.top.equalTo(searchButton.snp.top)
            make.trailing.equalTo(searchButton.snp.leading).offset(-padding)
            make.height.equalTo(searchButton.snp.height)
        }
    }

    func bindOutput() {
        viewModel.showHubHandler = { [unowned self] in
            self.view.makeToastActivity(.center)
        }

        viewModel.hideHubHandler = { [unowned self] in
            self.view.hideToastActivity()
        }

        viewModel.errorHandler = { [unowned self] (error) in
            self.view.makeToast(error.localizedDescription, duration: 1)
            switch error {
            case .cityEmpty, .cityFormatError:
                self.cityTextField.text = ""
            case .networkError, .parseError:
                break
            }
        }

        viewModel.updateWeather = { [unowned self] (model) in
            print(model)
        }
    }

    //MARK: - UI Events
    @objc
    func searchTapped() {
        viewModel.searchCityWeather(city: cityTextField.text)
    }

}
