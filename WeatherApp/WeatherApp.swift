//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by ravinder vatish on 9/13/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var coordinator = MainCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.showHomePage()
        }  .environmentObject(coordinator)
    }
}
