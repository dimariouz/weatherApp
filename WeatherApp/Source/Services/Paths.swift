//
//  Paths.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 27.02.2023.
//

import Foundation

enum Paths {
    case cityWeather(id: Int)
    case cityForecast(id: Int)
    
    var path: String {
        switch self {
        case .cityWeather:
            return "weather"
        case .cityForecast:
            return "forecast"
        }
    }
    
    var idParam: [String: String] {
        switch self {
        case .cityWeather(let id), .cityForecast(let id):
            return ["id": "\(id)"]
        }
    }
}
