//
//  MultiCityView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI

struct MultiCityView: View {
    
    @EnvironmentObject var platform: Platform
    @StateObject var viewModel: MultiCityViewModel
    
    var body: some View {
        ZStack {
            List(viewModel.searchedCitiesList, id: \.id) { city in
                WeatherCityRowView(model: city, metric: platform.metric)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        viewModel.showSingleCity(with: city)
                    }
            }
            .listStyle(.plain)
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(.circular)
                    
            }
        }
        .searchable(text: $viewModel.searchText)
        .navigationBarBackButtonHidden()
        .navigationTitle("Weather Combine")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("°C<->°F") {
                    platform.metric.toogle()
                }
            }
        }
        .onAppear {
            viewModel.getCityWeather()
        }
    }
}

struct MultiCityView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCityView(viewModel: MultiCityViewModel(router: Router(), weatherService: WeatherService(networkService: NetworkService())))
    }
}
