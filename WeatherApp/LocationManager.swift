//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Ravinder Vatish on 9/15/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    private var locationCompletion: ((CLAuthorizationStatus, CLLocation?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation(completion: @escaping (CLAuthorizationStatus, CLLocation?) -> Void) {
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        if let locationCompletion = locationCompletion {
            locationCompletion(manager.authorizationStatus, location)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .denied || status == .restricted || status == .authorizedWhenInUse || status == .authorizedAlways {
            if let locationCompletion = locationCompletion {
                locationCompletion(status, nil)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
        if let locationCompletion = locationCompletion {
            locationCompletion(manager.authorizationStatus, nil)
        }
    }
}
