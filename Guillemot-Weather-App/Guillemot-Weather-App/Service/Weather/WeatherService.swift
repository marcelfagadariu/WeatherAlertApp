//
//  WeatherService.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

protocol WeatherService {
    func fetchWeatherAlerts() async throws -> WeatherAlert
}
