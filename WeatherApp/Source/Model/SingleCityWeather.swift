//
//  SingleCityWeather.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import Foundation

struct SingleCityWeatherModel: Codable {
    let list: [Forecast]
    let city: City
}

struct Forecast: Codable {
    let date: TimeInterval
    let main: MainCondition
    let weather: [Weather]
    
    private enum CodingKeys: String, CodingKey {
        case main, weather
        case date = "dt"
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coodinates
}
