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
    private let imageService: ImageService

    // MARK: - Init

    init(weatherService: WeatherService, imageService: ImageService) {
        self.weatherService = weatherService
        self.imageService = imageService
    }

    // MARK: - Methods

    func getImage(completion: @escaping (URL?) -> Void) {
        Task {
            do {
                let image = try await imageService.fetchImageURL()
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }

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
