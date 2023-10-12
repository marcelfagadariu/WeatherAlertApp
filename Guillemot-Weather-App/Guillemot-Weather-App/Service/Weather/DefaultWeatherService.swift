//
//  DefaultWeatherService.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

class DefaultWeatherService: WeatherService {

    // MARK: - Internal

    let api: API
    let session: Session

    // MARK: - Init

    init(api: API = API.env, session: Session = Session()) {
        self.api = api
        self.session = session
    }

    func fetchWeatherAlerts() async throws -> WeatherAlert {
        let baseURLString = "\(api.rawValue)/alerts/active"
        var components = URLComponents(string: baseURLString)
        let statusQueryItem = URLQueryItem(name: "status", value: "actual")
        let messageTypeQueryItem = URLQueryItem(name: "message_type", value: "alert")
        components?.queryItems = [statusQueryItem, messageTypeQueryItem]
        // Create the URL from the URLComponents
        guard let url = components?.url else { throw InterfaceError.networkError }
        return try await session.get(url: url, headers: [:])
    }
}
