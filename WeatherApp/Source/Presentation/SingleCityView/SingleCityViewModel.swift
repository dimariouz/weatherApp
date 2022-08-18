//
//  SingleCityViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import Foundation

final class SingleCityViewModel {
    
    let platform: Platform
    var listCity: ListCityWeather?
    
    private(set) var city: SingleCityWeatherModel?
    
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
                guard let cityId = listCity?.id else {
                    let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Wrong city id"])
                    DispatchQueue.main.async {
                        self.didReceiveError?(error)
                    }
                    return
                }

                city = try await platform.weatherService.getSingleCityWeather(with: cityId)
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
