//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation
import Alamofire

protocol WeatherServiceProtocol: Any {
    func getWeatherList() async throws -> [ListCityWeather]
    func getSingleCityWeather(with id: Int) async throws -> SingleCityWeatherModel
}

final class WeatherService: WeatherServiceProtocol {
    
    let networkService: NetworkServiceProtocol
    
    let metricParams = ["units": "metric",
                        "appid": Constants.APIs.apiKey]
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getWeatherList() async throws -> [ListCityWeather] {
        var cities = [ListCityWeather]()
        for city in Cities.allCases {
            do {
                let city: ListCityWeather = try await networkService.get(path: Paths.cityWeather(id: city.id).path, params: metricParams.merge(Paths.cityWeather(id: city.id).idParam))
                cities.append(city)
            } catch {
                throw error
            }
        }
        return cities
    }
    
    func getSingleCityWeather(with id: Int) async throws -> SingleCityWeatherModel {
        try await networkService.get(path: Paths.cityForecast(id: id).path, params: metricParams.merge(Paths.cityForecast(id: id).idParam))
    }
}
