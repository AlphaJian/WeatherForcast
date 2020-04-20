//
//  BaseViewController.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/20.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        self.view.addGestureRecognizer(tap)
    }

    @objc
    func viewTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }


}
