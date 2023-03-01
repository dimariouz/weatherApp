//
//  Platform.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 28.02.2023.
//

import Foundation

class Platform: ObservableObject {
    @Published var metric: MetricState = .celsius
    let networkService: NetworkServiceProtocol
    let weatherService: WeatherServiceProtocol
    
    init() {
        networkService = NetworkService()
        weatherService = WeatherService(networkService: networkService)
    }
}
