//
//  Platform.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation

final class Platform {
    
    let networkService: NetworkServiceProtocol
    let weatherService: WeatherServiceProtocol
    
    static let shared = Platform()
    
    var metric: MetricState = .celsius
    
    private init() {
        networkService = NetworkService()
        weatherService = WeatherService(networkService: networkService)
    }
}
