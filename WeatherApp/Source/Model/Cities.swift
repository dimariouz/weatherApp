//
//  Cities.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation

enum Cities: CaseIterable {
    case London, TelAviv, NewYork, Brussels, Barcelona, Paris,
         Tokyo, Beijing, Sydney, BuenosAires, Miami, Vancouver,
         Moscow, Bangkok, Johannesburg, Tunis, Manila
    
    var id: Int {
        switch self {
        case .London:
            return 2643743
        case .TelAviv:
            return 293396
        case .NewYork:
            return 5128581
        case .Brussels:
            return 2800866
        case .Barcelona:
            return 3128760
        case .Paris:
            return 2988507
        case .Tokyo:
            return 1850147
        case .Beijing:
            return 1816670
        case .Sydney:
            return 2147714
        case .BuenosAires:
            return 3432043
        case .Miami:
            return 4164138
        case .Vancouver:
            return 6173331
        case .Moscow:
            return 524901
        case .Bangkok:
            return 1609350
        case .Johannesburg:
            return 993800
        case .Tunis:
            return 2464470
        case .Manila:
            return 1701668
        }
    }
}
