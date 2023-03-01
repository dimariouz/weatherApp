//
//  MultiCityViewModel.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI
import Combine

class MultiCityViewModel: ObservableObject {
    
    private let router: Router
    private let weatherService: WeatherServiceProtocol
    
    @Published var citiesList: [ListCityWeather] = []
    @Published var isLoading = false
    private var canellable: Set<AnyCancellable> = []
    
    init(router: Router, weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.router = router
    }
    
    func showSingleCity(with city: ListCityWeather) {
        router.showSingleCityView(city: city)
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
