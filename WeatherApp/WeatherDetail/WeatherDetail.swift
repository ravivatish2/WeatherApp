//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import SwiftUI

struct WeatherDetail: View {
    var selectedCity: GeocoderModel?
    @ObservedObject private var weatherViewModel: WeatherViewModel
    
    init(selectedCity: GeocoderModel) {
        self.selectedCity = selectedCity
        weatherViewModel = WeatherViewModel(city: selectedCity)
    }
    
    var body: some View {
        VStack {
            Text(String(weatherViewModel.cityData.main.temp))
        }
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(selectedCity: GeocoderModel(lat: 33.92, lon: -96.76, name: "Dallas", state: "TX", country: "USA")
)
    }
}
