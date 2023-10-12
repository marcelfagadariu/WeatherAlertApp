//
//  ImageService.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import Foundation.NSURL

protocol ImageService {
    func fetchImageURL() async throws -> URL
}
