//
//  WeatherAppCombineApp.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI

@main
struct WeatherAppCombineApp: App {
    @StateObject var platform = Platform()
    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                makeSplashView(with: router)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .singleCityView(let city):
                            makeSingleCityView(with: router, and: city)
                        case .multiCityView:
                            makeMultiCityView(with: router)
                        case .mapView(let city):
                            makeMapView(city: city)
                        }
                    }
            }
            .environmentObject(platform)
        }
    }
}

extension WeatherAppCombineApp {
    @ViewBuilder func makeSplashView(with router: Router) -> some View {
        SplashView(router: router)
    }
    
    @ViewBuilder func makeMultiCityView(with router: Router) -> some View {
        MultiCityView(viewModel: MultiCityViewModel(router: router, weatherService: platform.weatherService))
    }
    
    @ViewBuilder func makeSingleCityView(with router: Router, and city: ListCityWeather) -> some View {
        SingleCityView(viewModel: SingleCityViewModel(listCity: city, router: router, weatherService: platform.weatherService))
    }
    
    @ViewBuilder func makeMapView(city: ListCityWeather) -> some View {
        MapView(city: city)
    }
}
