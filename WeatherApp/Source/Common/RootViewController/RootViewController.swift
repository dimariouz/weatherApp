//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

class RootViewController: UIViewController, ActivityIndicatorPresenter, AlertPresenter {
    
    class var cellHeight: CGFloat {
        150
    }
   
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator =  UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundColor()
        setNavigationBarHidden()
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "°C<->°F", style: .plain, target: self, action: #selector(changeMetric))
    }
    
    @objc func changeMetric() {}

    func setupBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func push(to view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func setNavigationBarHidden(_ isHidden: Bool = false) {
        navigationController?.navigationBar.isHidden = isHidden
    }
    
    func setBackButtonHidden(_ isHidden: Bool) {
        navigationItem.setHidesBackButton(isHidden, animated: false)
    }
    
    func setLargeTitle(_ isLarge: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = isLarge
    }
    
    func handleError(with error: Error) {
        showAlert(message: error.localizedDescription)
    }
}
