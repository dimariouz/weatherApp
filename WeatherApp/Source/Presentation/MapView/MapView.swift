//
//  MapView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import UIKit
import MapKit

final class MapView: UIViewController {
    private enum C {
        static let radius: CLLocationDistance = 1000
    }

    @IBOutlet private weak var mapView: MKMapView!
    
    var city: ListCityWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMap()
    }
    
    private func configureMap() {
        guard let city = city else { return }
        let location = CLLocation(latitude: city.coordinates.lat, longitude: city.coordinates.lon)

        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: C.radius,
                                                  longitudinalMeters: C.radius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = city.name
        mapView.addAnnotation(annotation)
    }
}
