//
//  Constants.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import Foundation

typealias Closure<T> = (T) -> Void

enum Constants {
    enum Storyboards: String {
        case splash = "Splash"
        case multiCity = "MutliCity"
        case singleCity = "SingleCity"
        case map = "Map"
    }
    
    enum APIs {
        static var host: String {
            "https://api.openweathermap.org/data/2.5/"
        }
        
        static var apiKey: String {
            "0cd74bf29e43ef1ad6afd6861cc99eb2"
        }
        
        static func imageUrl(id: String) -> String {
            "https://openweathermap.org/img/wn/\(id)@2x.png"
        }
    }
}
