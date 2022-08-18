//
//  MetricState.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import Foundation

enum MetricState {
    case celsius
    case fahrenheit
    
    mutating func toogle() {
        switch self {
        case .celsius:
            self = .fahrenheit
        case .fahrenheit:
            self = .celsius
        }
    }
}

extension Double {
    func metricValue(_ metric: MetricState) -> String {
        switch metric {
        case .celsius:
            return "\(Int(self)) °C"
        case .fahrenheit:
            return "\(Int((self * 9 / 5) + 32)) °F"
        }
    }
}
