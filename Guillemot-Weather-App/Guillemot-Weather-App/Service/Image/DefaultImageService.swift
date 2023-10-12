//
//  DefaultImageService.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation

class DefaultImageService: ImageService {

    // MARK: - Internal

    let session: Session

    // MARK: - Init

    init(session: Session = Session()) {
        self.session = session
    }

    func fetchImageURL() async throws -> URL {
        guard let url = URL(string: "https://picsum.photos/1000") else { throw InterfaceError.networkError }
        return try await session.get( url: url, headers: [:])
    }
}
