//
//  WeatherAlertTableViewCell.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import UIKit
import SDWebImage

class WeatherAlertTableViewCell: UITableViewCell {

    // MARK: - @IBOutlet

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        weatherImageView.alpha = 0.2
    }

    func inflateWith(data: WeatherAlert.Properties) {
        eventNameLabel.text = data.event
        sourceLabel.text = data.senderName

        // End date
        updateLabel(label: endDate, withValue: data.ends?.formattedDate(), prefix: "Ending date")

        // Start date
        updateLabel(label: startDate, withValue: data.effective?.formattedDate(), prefix: "Starting date")

        // Duration
        updateLabel(label: durationLabel, withValue: data.duration?.formattedDuration, prefix: "Duration")

        // Image
        ImageDownloader.downloadImage() { [weak self] (image, error) in
            if let image = image {
                self?.weatherImageView.image = image
            } else if let error = error {
                self?.weatherImageView.image = UIImage(named: "placeholderImage")
                print("Error downloading image: \(error)")
            }
        }
    }

    func updateLabel(label: UILabel, withValue value: String?, prefix: String) {
        if let value = value {
            label.text = prefix + ": " + value
        } else {
            label.text = "Missing \(prefix.lowercased())"
        }
    }
}
