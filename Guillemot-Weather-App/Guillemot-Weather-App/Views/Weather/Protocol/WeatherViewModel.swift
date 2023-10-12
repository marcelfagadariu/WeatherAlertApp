//
//  WeatherViewModel.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

protocol WeatherViewModel {
    var isLoading: LoadingState { get set }
    var weatherAlerts: [WeatherAlert.Feature] { get set }
    func getWeatherAlerts()
}

enum LoadingState {
    case loading
    case loaded
    case failed(Error)

    var isLoading: Bool {
        if case .loading = self { return true } else { return false }
    }
}
