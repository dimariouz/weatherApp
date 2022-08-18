//
//  SingleCityView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import UIKit

final class SingleCityView: RootViewController {
    private enum C {
        static let title = " Forecast"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    private(set) var model = SingleCityViewModel(platform: Platform.shared)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
        
        model.getCityWeather()
    }
    
    private func setupBindings() {
        model.didReceiveResult = { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        model.didReceiveError = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(message: error.localizedDescription)
        }
        
        model.isLoading = { [weak self] isLoading in
            guard let self = self else { return }
            self.animateIndicator(isLoading)
        }
    }
    
    private func setupUI() {
        if let city = model.listCity,
            let weatherInfo = city.weather.first {
            nameLabel.text = "\(city.name)" + C.title
            iconImageView.downloaded(from: Constants.APIs.imageUrl(id: weatherInfo.icon))
        }
        setupTableView()
    }
    
    override func changeMetric() {
        model.platform.metric.toogle()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibs: [CityForecastTableViewCell.self])
    }
}

// MARK: - UITableViewDelegate
extension SingleCityView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SingleCityView.cellHeight
    }
}

// MARK: - UITableViewDataSource
extension SingleCityView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.city?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let city = model.city else { return UITableViewCell() }
        let cell = tableView.dequeue(cellClass: CityForecastTableViewCell.self, forIndexPath: indexPath)
        cell.configure(model: city.list[indexPath.row], metric: model.platform.metric)
        return cell
    }
}
