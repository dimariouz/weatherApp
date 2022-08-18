//
//  ActivityIndicatorPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

protocol ActivityIndicatorPresenter: AnyObject {
    var activityIndicator: UIActivityIndicatorView { get }
    func animateIndicator(_ animate: Bool)
}

extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func animateIndicator(_ animate: Bool) {
        if animate {
            view.addSubview(activityIndicator)
            activityIndicator.center = view.center
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
