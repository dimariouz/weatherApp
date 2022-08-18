//
//  WeatherCityTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

protocol WeatherCityTableViewCellDelegate: AnyObject {
    func openMap(for city: ListCityWeather)
}

final class WeatherCityTableViewCell: UITableViewCell {
    private enum C {
        static let maxTitle = "max "
        static let minTitle = "min "
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var maxValueLabel: UILabel!
    @IBOutlet private weak var minValueLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    private var city: ListCityWeather?
    weak var delegate: WeatherCityTableViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.cancelLoading()
        nameLabel.text = nil
        maxValueLabel.text = nil
        minValueLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(model: ListCityWeather, metric: MetricState) {
        self.city = model
        nameLabel.text = "\(model.name), \(model.system.country)"
        maxValueLabel.text = C.maxTitle + model.main.tempMax.metricValue(metric)
        minValueLabel.text = C.minTitle + model.main.tempMin.metricValue(metric)
        if let weatherInfo = model.weather.first {
            descriptionLabel.text = "\(weatherInfo.main) (\(weatherInfo.description))"
            iconImageView.downloaded(from: Constants.APIs.imageUrl(id: weatherInfo.icon))
        }
    }
    
    @IBAction private func openMapAction(_ sender: UIButton) {
        guard let city = city else { return }
        delegate?.openMap(for: city)
    }
}
