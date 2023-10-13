//
//  API.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

enum API: String, CaseIterable {
    static var env = API.dev

    case dev = "https://api.weather.gov"
    case image = "https://picsum.photos"

    func imageURL(index: Int) -> String {
        return "\(String(describing: API.image.rawValue))/\(index)"
    }
}
