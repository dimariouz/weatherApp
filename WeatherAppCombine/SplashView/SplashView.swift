//
//  SplashView.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import SwiftUI

struct SplashView: View {
    private enum C {
        static let routeDelay: TimeInterval = 3
    }
    
    @ObservedObject var router = Router<Path>(root: .splash)
    
    var body: some View {
        RouterView(router: router) { path in
            switch path {
            case .splash:
                ZStack {
                Color.indigo
                    .ignoresSafeArea()
                VStack {
                    Text("Weather App Combine")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold))
                    VStack {
                        HStack {
                            Image("01d")
                            Image("02d")
                        }
                        HStack {
                            Image("09d")
                            Image("13d")
                        }
                    }
                }
            }
            case .multiCityView:
                MultiCityView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + C.routeDelay) {
                router.push(.multiCityView)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
