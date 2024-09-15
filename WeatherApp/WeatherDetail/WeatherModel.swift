//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import Foundation

struct WeatherModel: Codable  {
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let name: String
    
    static  var defaultValue = WeatherModel(weather: [Weather(main: "", description: "", icon: "01d")], base: "", main: Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0), visibility: 0, name: "")
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let main, description, icon: String
}
