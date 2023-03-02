//
//  Router.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI

final class Router: ObservableObject {
    static let shared = Router()

    @Published var path = [Route]()
    
    func showSingleCityView(city: ListCityWeather) {
        path.append(.singleCityView(city))
    }
    
    func showMapView(city: ListCityWeather) {
        path.append(.mapView(city))
    }

    func showMultiCityView() {
        path.append(.multiCityView)
    }
    
    func backToRoot() {
        path.removeAll()
    }
    
    func back() {
        path.removeLast()
    }
}

enum Route {
    case multiCityView
    case singleCityView(ListCityWeather)
    case mapView(ListCityWeather)
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .multiCityView:
            hasher.combine("multiCityView".hashValue)
        case .singleCityView(let value):
            hasher.combine("singleCityView \(value.id)".hashValue)
        case .mapView(let value):
            hasher.combine("mapView \(value.id)".hashValue)
        }
    }
}

extension Route: Equatable {
    static func ==(lhs: Route, rhs: Route) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
