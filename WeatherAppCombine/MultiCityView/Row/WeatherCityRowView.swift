//
//  WeatherCityRowView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 27.02.2023.
//

import SwiftUI

struct WeatherCityRowView: View {
    private enum C {
        static let maxTitle = "max "
        static let minTitle = "min "
    }
    
    let model: ListCityWeather
    let metric: MetricState
    
    var body: some View {
        VStack {
            HStack {
                Text(model.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text(C.maxTitle + model.main.tempMax.metricValue(metric))
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.yellow)
                    Text(C.minTitle + model.main.tempMin.metricValue(metric))
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.mint)
                }
            }
            .padding(10)
            HStack {
                if let weatherInfo = model.weather.first {
                    VStack(alignment: .leading) {
                        Text("\(weatherInfo.main) (\(weatherInfo.description))")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        Button(action: {
                            print(1)
                        }) {
                            Text("Open Map")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    Spacer()
                    AsyncImage(url: URL(string: Constants.APIs.imageUrl(id: weatherInfo.icon)), content: { image in
                        image.resizable()
                    }, placeholder: { Text("Loading ...")
                            .background(Color.white)
                    })
                    .scaledToFill()
                    .clipped()
                    .frame(width: 100, height: 100)
                }
            }
            .padding(10)
        }
        .background(Color.indigo)
        .cornerRadius(8)
    }
}

struct WeatherCityRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCityRowView(model: ListCityWeather(id: 0, coordinates: Coodinates(lon: 1, lat: 1), weather: [.init(id: 0, main: "Clouds", description: "scattered clouds", icon: "03n")], main: MainCondition(temp: 1, feelsLike: 22, tempMin: 23, tempMax: 44), name: "London", system: .init(country: "asd")), metric: .celsius)
    }
}
