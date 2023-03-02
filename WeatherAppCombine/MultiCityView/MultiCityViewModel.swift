//
//  MultiCityViewModel.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI
import Combine

class MultiCityViewModel: ObservableObject {
    
    private let router: Router
    private let weatherService: WeatherServiceProtocol
    
    @Published private var citiesList: [ListCityWeather] = []
    @Published var searchedCitiesList: [ListCityWeather] = []
    @Published var isLoading = false
    @Published var searchText = ""
    
    private var canellable: Set<AnyCancellable> = []
    
    init(router: Router, weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.router = router
        
        $searchText
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveCompletion: { _ in
                //
            }, receiveValue: { [unowned self] searchText in
                self.searchedCitiesList = searchText.isEmpty ? self.citiesList : self.citiesList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            })
            .store(in: &canellable)
    }
    
    func showSingleCity(with city: ListCityWeather) {
        router.showSingleCityView(city: city)
    }
    
    func openMap(with city: ListCityWeather) {
        router.showMapView(city: city)
    }
    
    func getCityWeather() {
        isLoading = true
        weatherService.getWeatherList()
            .sink { [unowned self] completion in
                // handle error
                isLoading = false
            } receiveValue: { [unowned self] list in
                citiesList = list
                searchedCitiesList = list
            }
            .store(in: &canellable)
    }
}
