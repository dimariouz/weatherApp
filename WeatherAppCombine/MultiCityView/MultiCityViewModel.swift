//
//  MultiCityViewModel.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI
import Combine

class MultiCityViewModel: ObservableObject {
    
    let weatherService: WeatherServiceProtocol
    
    @Published var citiesList: [ListCityWeather] = []
    private var canellable: Set<AnyCancellable> = []
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getCityWeather() {
        weatherService.getWeatherList()
            .sink { completion in
                print(completion)
            } receiveValue: { list in
                print(list.count)
            }
            .store(in: &canellable)
//        let url = URL(string: Constants.APIs.host + Paths.cityWeather(id: 2643743).path)!
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: [ListCityWeather].self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                print(completion)
//            } receiveValue: { list in
//                print(list.count)
//            }
//            .store(in: &canellable)
    }
}
