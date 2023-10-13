//
//  WeatherAlertTableViewCell.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import UIKit
import SDWebImage

enum Constants: String {
    case placeholder = "placeholderImage"
}

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
        weatherImageView.alpha = 0.4
    }

    func inflateWith(data: WeatherAlert.Properties, index: Int) {
        eventNameLabel.text = data.event
        sourceLabel.text = data.senderName

        // End date
        updateLabel(label: endDate, withValue: data.ends?.formattedDate(), prefix: "Ending date")

        // Start date
        updateLabel(label: startDate, withValue: data.effective?.formattedDate(), prefix: "Starting date")

        // Duration
        updateLabel(label: durationLabel, withValue: data.duration?.formattedDuration, prefix: "Duration")

        // Image

        let placeholderImage = UIImage(named: Constants.placeholder.rawValue)
        if let url = URL(string: API.image.imageURL(index: index)) {
            weatherImageView.sd_setImage(with: url, placeholderImage: placeholderImage)
        } else {
            weatherImageView.image = placeholderImage
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
