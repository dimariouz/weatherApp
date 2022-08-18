//
//  SplashView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

final class SplashView: RootViewController {
    private enum C {
        static let routeDelay: TimeInterval = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        routeToAlbumsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemIndigo
    }
    
    private func routeToAlbumsView() {
        let view: MutliCityView = .instantiate(storyboard: .multiCity)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + C.routeDelay) {
            self.push(to: view)
        }
    }
    
}
