//
//  InterfaceError.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

public enum InterfaceError: Error, LocalizedError, Identifiable {
    case internalError
    case networkError
    case specialized(error: LocalizedError)
    case unknown(message: String)

    public var id: String {
        switch self {
        case .internalError:
            return "invalid_error"
        case .networkError:
            return "network_error"
        case .specialized:
            return "specialized_error"
        case .unknown:
            return "unknown_error"
        }
    }

    public var errorDescription: String? {
        switch self {
        case .internalError:
            return "Please try again later"
        case .networkError:
            return "Please check your connection and try again"
        case .specialized(error: let error):
            return error.errorDescription
        case .unknown(message: let message):
            return message
        }
    }
}
