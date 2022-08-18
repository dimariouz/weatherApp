//
//  UIImageView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func cancelLoading() {
        self.af.cancelImageRequest()
    }
    
    func downloaded(from url: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let placeholder = UIImage(systemName: "photo")
        guard let urlString = url, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        self.af.setImage(withURL: url, placeholderImage: placeholder)
    }
}
