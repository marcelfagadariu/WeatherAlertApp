//
//  DefaultImageService.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import SDWebImage

class ImageDownloader {
    class func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        let imageManager = SDWebImageManager.shared
        guard let imageURL = URL(string: "https://picsum.photos/1000") else { return }

        imageManager.loadImage(
            with: imageURL,
            options: .highPriority,
            progress: nil,
            completed: { image, data, error, cacheType, isFinished, imageURL in
                if let error = error {
                    completion(nil, error)
                } else if isFinished, let downloadedImage = image {
                    completion(downloadedImage, nil)
                }
            }
        )
    }
}
