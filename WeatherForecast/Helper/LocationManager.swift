//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by ken.zhang on 2020/4/17.
//  Copyright © 2020 ken.zhang. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()

    private var locationManager: CLLocationManager?

    var locationHandler: (((String, CoordinateModel)) -> Void)?

    func startPositioning() {

        if CLLocationManager.authorizationStatus() == .denied{
            // 定位提示
            alert()
        } else {
            requestLocationServicesAuthorization()
        }
    }

    private func requestLocationServicesAuthorization() {

        if (self.locationManager == nil) {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
        }

        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.startUpdatingLocation()

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined) {
            locationManager?.requestWhenInUseAuthorization()
        }

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            let distance : CLLocationDistance = 10.0
            locationManager?.distanceFilter = distance
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
    }

    private func reportLocationServicesAuthorizationStatus(status:CLAuthorizationStatus) {

        if status == .notDetermined {
            requestLocationServicesAuthorization()
        } else if (status == .restricted) {
            alert()
        } else if (status == .denied) {
            alert()
        }
    }

    private func alert() {
        let alert = UIAlertController(title: "Attention", message: "Please open GPS", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "Ok", style: .default) { (action) in
            let url = URL(fileURLWithPath: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        UIApplication.currentViewController?.present(alert, animated: true, completion: nil)

    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if error != nil {
                return
            }

            if let place = placemarks?[0], let city = place.locality, !city.isEmpty {
                self?.locationHandler?((city, CoordinateModel(latitude: location.coordinate.latitude, lontitude: location.coordinate.longitude)))
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        reportLocationServicesAuthorizationStatus(status: status)
    }
}

