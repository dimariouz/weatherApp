//
//  SingleCityView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 28.02.2023.
//

import SwiftUI

struct SingleCityView: View {
    
    private enum C {
        static let title = " Forecast"
    }
        
    @EnvironmentObject var platform: Platform
    @StateObject var viewModel: SingleCityViewModel
    
    var body: some View {
        VStack {
            if let city = viewModel.listCity,
               let weatherInfo = city.weather.first {
                AsyncImage(url: URL(string: Constants.APIs.imageUrl(id: weatherInfo.icon)), content: { image in
                    image.resizable()
                }, placeholder: { Text("Loading ...")
                        .background(Color.white)
                })
                .scaledToFill()
                .clipped()
                .frame(width: 100, height: 100)
                Text("\(city.name)" + C.title)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
            }
            
            if let city = viewModel.city {
                List(city.list, id: \.id) { forecast in
                    CityForecastRowView(model: forecast, metric: platform.metric)
                        .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
           
        }
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

struct SingleCityView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
