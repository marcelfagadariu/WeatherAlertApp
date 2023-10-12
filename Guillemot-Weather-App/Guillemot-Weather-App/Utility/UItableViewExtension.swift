//
//  UItableViewExtension.swift
//  Guillemot-Weather-App
//
//  Created by Marcel on 12.10.2023.
//

import UIKit

extension UITableViewCell {
    static func registerWith(tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: Bundle(for: self)), forCellReuseIdentifier: String(describing: self))
    }

    static var name: String {
        String(describing: self)
    }
}
