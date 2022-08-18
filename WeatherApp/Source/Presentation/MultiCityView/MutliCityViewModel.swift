//
//  MutliCityViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation

final class MutliCityViewModel {
    let platform: Platform
    
    private(set) var citiesList: [ListCityWeather] = []
    var searchedCities: [ListCityWeather] = []
    
    var didReceiveError: Closure<Error>?
    var didReceiveResult: Closure<Void>?
    var isLoading: Closure<Bool>?
    
    init(platform: Platform) {
        self.platform = platform
    }
    
    func getCityWeather() {
        isLoading?(true)
        Task {
            do {
                citiesList = try await platform.weatherService.getWeatherList()
                searchedCities = citiesList
                DispatchQueue.main.async {
                    self.didReceiveResult?(())
                    self.isLoading?(false)
                }
            } catch {
                DispatchQueue.main.async {
                    self.didReceiveError?(error)
                    self.isLoading?(false)
                }
            }
        }
    }
    
}
