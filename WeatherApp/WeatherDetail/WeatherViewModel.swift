//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var cityData: WeatherModel = WeatherModel.defaultValue
    @Published var image: UIImage?

    private var city: GeocoderModel
    private var cancellableSet: Set<AnyCancellable> = []
    private var cache = NSCache<NSURL, UIImage>()
    
    
    init(city: GeocoderModel) {
        self.city = city
        let weatherApi = ApiRequest(api: .latLongWeather, params: ["lat" : String(city.lat),
                                                                   "lon" : String(city.lon),
                                                                   "limit": "15"])
        ConnectionManager.shared.getData(apiRequest: weatherApi, responseType: WeatherModel.self).sink { _ in
        } receiveValue: { weatherData in
            self.cityData = weatherData
        }.store(in: &cancellableSet)
    
    }
    
    // Function to load image from URL with caching
    func loadImage(from url: URL) {
        
        let nsURL = url as NSURL
        var cancellableSet: Set<AnyCancellable> = []
        
        // Check if the image is cached
        if let cachedImage = cache.object(forKey: nsURL) {
            self.image = cachedImage
            return
        }
        
        let weatherApi = ApiRequest(api: .image, params: ["lat" : ])
        ConnectionManager.shared.getData(apiRequest: weatherApi, responseType: WeatherModel.self).sink { _ in
        } receiveValue: { weatherData in
            self.cityData = weatherData
        }.store(in: &cancellableSet)
        
    }
            
            
            
}

