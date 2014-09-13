//
//  WeatherForecast.swift
//  ff14booklet
//
//  Created by tomohiro-moro on 9/14/14.
//  Copyright (c) 2014 slightair. All rights reserved.
//

import Foundation

struct Weather {
    var title = "Unknown"
    var imageURL: NSURL? = nil
}

struct WeatherForecastLocation {
    var title = "Unknown"
    var forecasts: [Weather]
}

struct WeatherForecastInfo {
    var date: String
    var forecastDates: [String]
}

struct WeatherForecast {
    var info: WeatherForecastInfo
    var locations: [WeatherForecastLocation]
}