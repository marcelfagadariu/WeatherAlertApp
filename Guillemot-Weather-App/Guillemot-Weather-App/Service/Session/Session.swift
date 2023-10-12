//
//  Session.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

struct Session {

    // MARK: - Private

    private let session: URLSession

    // MARK: - Init

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - HTTP Method

    enum Method: String, CaseIterable {
        case get = "GET"
    }

    // MARK: - Factory URLRequest

    func request(url: URL, method: Method, headers: [String: String]) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        for key in headers.keys {
            urlRequest.addValue(headers[key] ?? "", forHTTPHeaderField:key)
        }
        return urlRequest
    }

    // MARK: - Requests

    func data<Response: Decodable>(for request: URLRequest) async throws -> Response {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode < 300 else {
            let error = String(data: data, encoding: .utf8) ?? "Unknown Error"
            throw InterfaceError.unknown(message: error)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: data)
    }

    func get<Response: Decodable>(url: URL, headers: [String: String]) async throws -> Response {
        try await data(for: try request(url: url, method: .get, headers: headers))
    }
}
