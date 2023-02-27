//
//  WeatherService.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 27.02.2023.
//

import Combine

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherList() -> AnyPublisher<[ListCityWeather], Error>
    func getSingleCityWeather(with id: Int) -> AnyPublisher<SingleCityWeatherModel, Error>
}

final class WeatherService: WeatherServiceProtocol {
    
    let networkService: NetworkServiceProtocol
    
    private var metricParams = ["units": "metric",
                                 "appid": Constants.APIs.apiKey]
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getWeatherList() -> AnyPublisher<[ListCityWeather], Error> {
        let citiesPublishers = Cities.allCases.map { city -> AnyPublisher<ListCityWeather, Error> in
            networkService.get(path: Paths.cityWeather(id: city.id).path, params: metricParams.merge(Paths.cityWeather(id: city.id).idParam))
        }
        return Publishers.MergeMany(citiesPublishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    func getSingleCityWeather(with id: Int) -> AnyPublisher<SingleCityWeatherModel, Error> {
        networkService.get(path: Paths.cityForecast(id: id).path, params: metricParams.merge(Paths.cityForecast(id: id).idParam))
    }
    
}
