//
//  GeocoderModel.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import Foundation

import Foundation

struct GeocoderModel: Identifiable, Hashable {
    var id = UUID()
    let lat: Float
    let lon: Float
    let name : String
    let state: String
    let country: String
}

extension GeocoderModel: Codable {
    enum CodingKeys: String, CodingKey {
        case lat, lon, name, state, country
    }
}

