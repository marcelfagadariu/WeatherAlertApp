//
//  WeatherAlertViewController.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import UIKit

final class WeatherAlertViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Internal

    let viewModel: DefaultWeatherViewModel
    var activityIndicator: UIActivityIndicatorView!

    // MARK: - Init

    init(viewModel: DefaultWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let defaultViewModel = DefaultWeatherViewModel(weatherService: DefaultWeatherService(),
                                                       imageService: DefaultImageService() )
        self.viewModel = defaultViewModel
        super.init(coder: coder)
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        initSpinner()
        setupUI()
        fetchWeatherAlerts()
    }

    // MARK: - Private methods

    private func registerCell() {
        WeatherAlertTableViewCell.registerWith(tableView: tableView)
    }

    private func setupUI() {
        viewModel.loadingStateChangedCallback = { [weak self] loadingState in
            guard let self else { return }
            // Update UI elements based on the loading state
            DispatchQueue.main.async {
                switch loadingState {
                case .failed(let error):
                    self.showAlert(with: "Error", message: error.localizedDescription)
                case .loading:
                    self.startSpinner()
                case .loaded:
                    self.stopSpinner()
                }
            }
        }

        viewModel.weatherAlertsUpdatedCallback = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func fetchWeatherAlerts() {
        viewModel.getWeatherAlerts()
    }

    // MARK: - Spinner methods

    private func initSpinner() {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)
    }

    private func startSpinner() {
        activityIndicator.startAnimating()
    }

    private func stopSpinner() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension WeatherAlertViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = viewModel.weatherAlerts[indexPath.row].properties
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherAlertTableViewCell.name) as? WeatherAlertTableViewCell else { return UITableViewCell() }
        cell.inflateWith(data: property, image: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.weatherAlerts.count
    }
}

// MARK: - UITableViewDelegate

extension WeatherAlertViewController: UITableViewDelegate {
    
}


// MARK: - Alert

extension WeatherAlertViewController {
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
