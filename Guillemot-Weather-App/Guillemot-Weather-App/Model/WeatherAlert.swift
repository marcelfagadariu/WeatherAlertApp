//
//  WeatherAlert.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

/// event name "event", start date "effective", end date "ends", source "senderName" & duration (start date - end date)
struct WeatherAlert: Decodable {
    let features: [Feature]

    // MARK: - Feature
    struct Feature: Decodable {
        let properties: Properties
    }

    // MARK: - Properties
    struct Properties: Decodable {
        let effective, ends: Date?
        let event, senderName: String

        // MARK: - Computed property

        var duration: TimeInterval? { ends?.timeIntervalSince(effective ?? Date()) }
    }

    // MARK: - Mock for testing

    static var mock: Properties {
        Properties(effective: .distantPast, ends: .distantFuture, event: "Some event", senderName: "Some name")
    }
}
