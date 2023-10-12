//
//  DefaultWeatherViewModel.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

final class DefaultWeatherViewModel: WeatherViewModel {

    // MARK: - Internal

    var isLoading: LoadingState = .loading {
        didSet {
            loadingStateChangedCallback?(isLoading)
        }
    }
    var weatherAlerts: [WeatherAlert.Feature] = [] {
        didSet {
            weatherAlertsUpdatedCallback?()
        }
    }

    var loadingStateChangedCallback: ((LoadingState) -> Void)?
    var weatherAlertsUpdatedCallback: (() -> Void)?


    // MARK: - Private

    private let weatherService: WeatherService

    // MARK: - Init

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }

    // MARK: - Methods

    func getWeatherAlerts() {
        Task {
            await MainActor.run {
                isLoading = .loading
            }
            do {
                let allWeatherAlerts = try await weatherService.fetchWeatherAlerts()
                await MainActor.run {
                    weatherAlerts = allWeatherAlerts.features
                    isLoading = .loaded
                }
            } catch {
                isLoading = .failed(error)
            }
        }
    }
}
