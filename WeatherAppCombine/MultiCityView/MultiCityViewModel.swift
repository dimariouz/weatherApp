//
//  MultiCityViewModel.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI
import Combine

class MultiCityViewModel: ObservableObject {
    
    let weatherService: WeatherServiceProtocol
    
    @Published var citiesList: [ListCityWeather] = []
    @Published var isLoading = false
    private var canellable: Set<AnyCancellable> = []
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getCityWeather() {
        isLoading = true
        weatherService.getWeatherList()
            .sink { [unowned self] completion in
                // handle error
                isLoading = false
            } receiveValue: { [unowned self] list in
                citiesList = list
            }
            .store(in: &canellable)
    }
}
