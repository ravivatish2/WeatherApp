//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.

import Foundation
import SwiftUI

class MainCoordinator : ObservableObject {
    
    func showHomePage() -> HomePage {
        return HomePage(coordinator: self)
    }
    
    func showWeatherDetail(_ selectedCity :  GeocoderModel) -> WeatherDetail {
        return WeatherDetail(selectedCity: selectedCity)
    }
    
    func showSearchBar(text: Binding<String>) -> SearchBar {
        return SearchBar(text: text)
    }
    
}
