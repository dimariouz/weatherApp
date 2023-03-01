//
//  SingleCityViewModel.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 28.02.2023.
//

import SwiftUI
import Combine

class SingleCityViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var city: SingleCityWeatherModel?
    
    let weatherService: WeatherServiceProtocol
    let listCity: ListCityWeather
    private let router: Router
    
    private var canellable: Set<AnyCancellable> = []
    
    init(listCity: ListCityWeather, router: Router, weatherService: WeatherServiceProtocol) {
        self.listCity = listCity
        self.weatherService = weatherService
        self.router = router
    }
    
    func getCityWeather() {
        isLoading = true
        weatherService.getSingleCityWeather(with: listCity.id)
            .sink { [unowned self] completion in
                // handle error
                isLoading = false
            } receiveValue: { [unowned self] result in
                city = result
            }
            .store(in: &canellable)
    }
    
}
