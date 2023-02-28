//
//  ListCityWeather.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation

struct ListCityWeather: Codable, Identifiable {
    let id: Int
    let coordinates: Coodinates
    let weather: [Weather]
    let main: MainCondition
    let name: String
    let system: System
   
    private enum CodingKeys: String, CodingKey {
        case id, weather, main, name
        case coordinates = "coord"
        case system = "sys"
    }
}

struct Coodinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainCondition: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct System: Codable {
    let country: String
}
