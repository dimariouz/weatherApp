//
//  CityForecastRowView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 01.03.2023.
//

import SwiftUI

struct CityForecastRowView: View {
    private enum C {
        static let maxTitle = "max "
        static let minTitle = "min "
    }
    
    let model: Forecast
    let metric: MetricState
    
    var body: some View {
        VStack {
            Text(model.date.dateString)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .padding(10)
            VStack {
                if let weatherInfo = model.weather.first {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(weatherInfo.main) (\(weatherInfo.description))")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
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
            }
        }
        .background(Color.indigo)
        .cornerRadius(8)
    }
}

struct CityForecastRowView_Previews: PreviewProvider {
    static var previews: some View {
        CityForecastRowView(model: Forecast(date: 1677693600, main: MainCondition(temp: 11, feelsLike: 22, tempMin: 23, tempMax: 42), weather: []), metric: .celsius)
    }
}
