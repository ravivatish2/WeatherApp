//
//  ConnectionError.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//

import Foundation

enum ConnectionError: Error {
    case networkError
    case decodingFailed
    case unknown
}

