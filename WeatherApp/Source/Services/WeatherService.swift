//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation
import Alamofire

private enum Paths {
    case cityWeather(id: Int)
    case cityForecast(id: Int)
    
    var path: String {
        switch self {
        case .cityWeather(let id):
            return "weather?id=\(id)"
        case .cityForecast(let id):
            return "forecast?id=\(id)"
        }
    }
}

protocol WeatherServiceProtocol: Any {
    func getWeatherList() async throws -> [ListCityWeather]
    func getSingleCityWeather(with id: Int) async throws -> SingleCityWeatherModel
}

final class WeatherService: WeatherServiceProtocol {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getWeatherList() async throws -> [ListCityWeather] {
        var cities = [ListCityWeather]()
        for city in Cities.allCases {
            do {
                let city: ListCityWeather = try await networkService.get(path: Paths.cityWeather(id: city.id).path)
                cities.append(city)
            } catch {
                throw error
            }
        }
        return cities
    }
    
    func getSingleCityWeather(with id: Int) async throws -> SingleCityWeatherModel {
        try await networkService.get(path: Paths.cityForecast(id: id).path)
    }
}
