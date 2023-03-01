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

    let router: Router
    
    var body: some View {
        
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + C.routeDelay) {
                router.showMultiCityView()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(router: Router())
    }
}
