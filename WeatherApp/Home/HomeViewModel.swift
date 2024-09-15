//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

class HomePageViewModel: ObservableObject {
    @Published var text = ""
    @Published var cityList : [GeocoderModel] = []
    
    private var locationManager = LocationManager()
    private let lastLocationKey = "lastKnownLocation" // Key to store location in UserDefaults
    private var cancellableSet: Set<AnyCancellable> = []
   
    init() {
        requestUserLocation()
    }
    
    func fetchLocation() {
        $text.sink { text in
            let getCityApi = ApiRequest(api: .getCities, params: ["q" : text, "limit": "15"])
            ConnectionManager.shared.getData(apiRequest: getCityApi, responseType: [GeocoderModel].self).sink { _ in
            } receiveValue: { list in
                self.cityList = list
            }.store(in: &self.cancellableSet)
        }
        .store(in: &cancellableSet)
    }

    // Function to fetch the location once and update the ViewModel's published properties
    func requestUserLocation() {
         var cancellableSet: Set<AnyCancellable> = []
        
        locationManager.requestLocation { [weak self] status, location in
            if( status == .authorizedWhenInUse || status == .authorizedAlways )
            {
                if let _coordinate = location?.coordinate {
                    
                   let weatherApi =  ApiRequest(api: .latLongWeather, params: ["lat" : String(_coordinate.latitude),
                                                              "lon" : String((_coordinate.longitude)),
                                                              "limit": "15"])
                    ConnectionManager.shared.getData(apiRequest: weatherApi, responseType: WeatherModel.self).sink { _ in
                    } receiveValue: { weatherData in
                       // self.cityData = weatherData
                        self?.text = weatherData.name
                        self?.saveLastLocation(weatherData.name)
                        self?.fetchLocation()
                        
                    }.store(in: &cancellableSet)
                }
                else {
                    // some issue to fetch the location
                    // fallback to stored location
                    self?.retrieveLastLocation();
                }
            }
            else {
                // location access is not authorized
                self?.retrieveLastLocation()
            }
            
        }
    }
    
    // Save the last fetched location in UserDefaults
    private func saveLastLocation(_ locationName: String ) {
        UserDefaults.standard.set(locationName, forKey: lastLocationKey)
    }
    
    // Retrieve the last known location from UserDefaults
    private func retrieveLastLocation() {
        if let locationData = UserDefaults.standard.string(forKey: lastLocationKey) {
            text = locationData
        }
    }
}






