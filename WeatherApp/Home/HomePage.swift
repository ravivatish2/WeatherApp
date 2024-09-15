//
//  ContentView.swift
//  WeatherApp
//
//  Created by ravinder vatish on 9/13/24.
//

import SwiftUI

struct HomePage: View {
    var coordinator: MainCoordinator
    @ObservedObject private var homePageViewModel =    HomePageViewModel()
    var body: some View {
        NavigationView {
            VStack {
                coordinator.showSearchBar(text: $homePageViewModel.text)
                List($homePageViewModel.cityList, id: \.self) { $city in
                    NavigationLink (destination:
                                        coordinator.showWeatherDetail(city)
                                        )
                                        {
                        HStack {
                            Text(city.name)
                            Text(city.country)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomePage(coordinator: MainCoordinator())
    }
}
