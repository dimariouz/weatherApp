//
//  MapView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 02.03.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    private enum C {
        static let radius: CLLocationDistance = 1000
    }
        
    @State private var region: MKCoordinateRegion
    private var locations: [Location] = []
        
    init(city: ListCityWeather) {
        let location = CLLocation(latitude: city.coordinates.lat,
                                       longitude: city.coordinates.lon)
        region = MKCoordinateRegion(center: location.coordinate,
                                    latitudinalMeters: C.radius,
                                    longitudinalMeters: C.radius)
        locations.append(Location(name: city.name, coordinate: location.coordinate))
    }
    
    var body: some View {
        makeMap()
    }
    
    @ViewBuilder func makeMap() -> some View {
        Map(coordinateRegion: $region, annotationItems: locations) { place in
            MapMarker(coordinate: place.coordinate,
                               tint: Color.purple)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension MapView {
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(city: ListCityWeather.init(id: 0, coordinates: Coodinates(lon: 0, lat: 0), weather: [], main: MainCondition(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0), name: "", system: .init(country: "")))
    }
}
