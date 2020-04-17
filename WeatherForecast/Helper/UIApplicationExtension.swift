//
//  UIApplicationExtension.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit

extension UIApplication {
    static var currentViewController: UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }

        return getCurrentViewController(from: rootViewController)
    }

    private static func getCurrentViewController(from viewController: UIViewController) -> UIViewController {
        switch viewController {
        case is UINavigationController:
            return getCurrentViewController(from: (viewController as! UINavigationController).visibleViewController!)
        case is UITabBarController:
            return getCurrentViewController(from: (viewController as! UITabBarController).selectedViewController!)
        default:
            if let presentedViewController = viewController.presentedViewController {
                return getCurrentViewController(from: presentedViewController)
            } else {
                return viewController
            }
        }
    }
}
