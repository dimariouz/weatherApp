//
//  MultiCityView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI

struct MultiCityView: View {
    
    @StateObject private var viewModel = MultiCityViewModel()
    
    var body: some View {
        List(viewModel.citiesList, id: \.id) { city in
            Text(city.name)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Weather Combine")
        .toolbar {
            Button("°C<->°F") {
                print("About tapped!")
            }
        }
        .onAppear {
            viewModel.getCityWeather()
        }
    }
}

struct MultiCityView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCityView()
    }
}
