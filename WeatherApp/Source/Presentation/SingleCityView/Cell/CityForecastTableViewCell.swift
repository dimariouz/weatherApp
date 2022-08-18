//
//  CityForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import UIKit

final class CityForecastTableViewCell: UITableViewCell {
    private enum C {
        static let maxTitle = "max "
        static let minTitle = "min "
    }

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var maxValueLabel: UILabel!
    @IBOutlet private weak var minValueLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.cancelLoading()
        maxValueLabel.text = nil
        minValueLabel.text = nil
        descriptionLabel.text = nil
    }

    func configure(model: Forecast, metric: MetricState) {
        dayLabel.text = model.date.dateString
        maxValueLabel.text = C.maxTitle + model.main.tempMax.metricValue(metric)
        minValueLabel.text = C.minTitle + model.main.tempMin.metricValue(metric)
        
        if let weatherInfo = model.weather.first {
            descriptionLabel.text = "\(weatherInfo.main) (\(weatherInfo.description))"
            iconImageView.downloaded(from: Constants.APIs.imageUrl(id: weatherInfo.icon))
        }
    }
}
