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
        lbl.textAlignment = .left
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
    
    lazy var selectionView: UISegmentedControl = {
        let control = UISegmentedControl(items: viewModel.unitSelections.map{$0.rawValue})
        control.selectedSegmentIndex = 0
        return control
    }()

    lazy var weatherTableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        
        tb.register(WeatherForecastTableViewCell.self, forCellReuseIdentifier: WeatherForecastTableViewCell.identifier)
        tb.dataSource = self
        tb.delegate = self
        
        return tb
    }()

    //MARK: - Property
    var viewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = WeatherViewModel()

        layoutUI()

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
        
        view.addSubview(selectionView)
        selectionView.snp.makeConstraints { (make) in
            make.top.equalTo(cityTextField.snp.bottom).offset(padding)
            make.leading.equalTo(cityLabel.snp.leading)
            make.trailing.equalTo(searchButton.snp.trailing)
            make.height.equalTo(30)
        }
        selectionView.addTarget(self, action: #selector(unitSelected(sender:)), for: .valueChanged)
        
        view.addSubview(weatherTableView)
        weatherTableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(selectionView.snp.bottom).offset(padding)
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

        viewModel.updateWeather = { [unowned self] in
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }

    //MARK: - UI Events
    @objc
    func searchTapped() {
        viewModel.searchCityWeather(city: cityTextField.text)
    }
    
    @objc func unitSelected(sender: UISegmentedControl) {
        viewModel.setWeatherUnit(index: sender.selectedSegmentIndex)
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherForecastCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.identifier, for: indexPath) as! WeatherForecastTableViewCell
        
        cell.setModel(model: viewModel.weatherForecastDataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = WeatherForecastTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 30))
        view.setUnit(unit: viewModel!.weatherUnit.unit)
        view.backgroundColor = UIColor.gray
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
