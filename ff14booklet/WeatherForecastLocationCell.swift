//
//  WeatherForecastLocationCell.swift
//  ff14booklet
//
//  Created by tomohiro-moro on 9/14/14.
//  Copyright (c) 2014 slightair. All rights reserved.
//

import UIKit

class WeatherForecastLocationCell: UITableViewCell {
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var forecastImageView1: UIImageView!
    @IBOutlet var forecastImageView2: UIImageView!
    @IBOutlet var forecastImageView3: UIImageView!
    @IBOutlet var forecastImageView4: UIImageView!
    @IBOutlet var forecastLabel1: UILabel!
    @IBOutlet var forecastLabel2: UILabel!
    @IBOutlet var forecastLabel3: UILabel!
    @IBOutlet var forecastLabel4: UILabel!

    func updateWithLocation(location: WeatherForecastLocation) {
        self.locationLabel.text = location.location.title()

        for i in 1...4 {
            let imageView = self.valueForKey("forecastImageView\(i)") as? UIImageView
            let label = self.valueForKey("forecastLabel\(i)") as? UILabel
            let weather = location.forecasts[i - 1]

            label?.text = weather.title()
            if let imageURL = weather.imageURL() {
                imageView?.sd_setImageWithURL(imageURL)
            } else {
                imageView?.image = nil
            }
        }
    }
}
