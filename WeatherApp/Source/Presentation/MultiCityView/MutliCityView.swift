//
//  MutliCityView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

final class MutliCityView: RootViewController {
    private enum C {
        static let cellHeight: CGFloat = 150
        static let title = "Weather"
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let model = MutliCityViewModel(platform: Platform.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        model.getCityWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        setBackButtonHidden(true)
        title = C.title
        setupTableView()
        setupSearchbar()
    }
    
    override func changeMetric() {
        model.platform.metric.toogle()
        tableView.reloadData()
    }
    
    private func setupSearchbar() {
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibs: [WeatherCityTableViewCell.self])
    }
    
    private func openSingleCity(with city: ListCityWeather) {
        let view: SingleCityView = .instantiate(storyboard: .singleCity)
        view.model.listCity = city
        push(to: view)
    }
    
    private func openMap(with city: ListCityWeather) {
        let view: MapView = .instantiate(storyboard: .map)
        view.city = city
        push(to: view)
    }
}

// MARK: - UITableViewDelegate
extension MutliCityView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = model.searchedCities.isEmpty ? model.citiesList : model.searchedCities
        openSingleCity(with: data[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MutliCityView.cellHeight
    }
}

// MARK: - UITableViewDataSource
extension MutliCityView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.searchedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: WeatherCityTableViewCell.self, forIndexPath: indexPath)
        let data = model.searchedCities.isEmpty ? model.citiesList : model.searchedCities
        cell.configure(model: data[indexPath.row], metric: model.platform.metric)
        cell.delegate = self
        return cell
    }
}

// MARK: - WeatherCityTableViewCellDelegate
extension MutliCityView: WeatherCityTableViewCellDelegate {
    func openMap(for city: ListCityWeather) {
        openMap(with: city)
    }
}

// MARK: - UISearchBarDelegate
extension MutliCityView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchedCities = searchText.isEmpty ? model.citiesList : model.citiesList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
