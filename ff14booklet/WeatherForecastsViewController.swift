//
//  WeatherForecastsViewController.swift
//  ff14booklet
//
//  Created by tomohiro-moro on 9/13/14.
//  Copyright (c) 2014 slightair. All rights reserved.
//

import UIKit

class WeatherForecastsViewController: UITableViewController {
    var weatherForecast: WeatherForecast? = nil

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cloudIcon = FAKFoundationIcons.cloudIconWithSize(TabBarItemIconFontSize)
        let iconImage = cloudIcon.imageWithSize(TabBarItemIconImageSize)
        self.tabBarItem = UITabBarItem(title: "天気予報", image: iconImage, selectedImage: iconImage);

        self.reloadForecast()
    }

    func reloadForecast() {
        let apiURL = NSURL(string: "https://www.kimonolabs.com/api/b33o6f7q?apikey=mELUT549EVbW77V9w9nwoMd6gt5KPbbe")
        NSURLSession.sharedSession().dataTaskWithURL(apiURL, completionHandler: {
            (data, response, error) in
            if error != nil {
                return
            }

            self.parseForecast(JSONValue(data))

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.navigationItem.title = self.weatherForecast?.info.date
            })
        }).resume()
    }

    func parseForecast(data: JSONValue) {
        func createWeatherForecastLocation(locationData: JSONValue) -> WeatherForecastLocation {
            let title = locationData["title"].string!

            var weathers: [Weather] = []
            for i in 1...4 {
                if let weatherTitle = locationData["forecast\(i)_title"].string {
                    if countElements(weatherTitle) > 0 {
                        weathers.append(Weather(title: weatherTitle, imageURL: locationData["forecast\(i)_image"].url))
                    }
                } else {
                    weathers.append(Weather())
                }
            }
            return WeatherForecastLocation(title: title, forecasts: weathers)
        }

        func createWeatherForecastInfo(metaData: JSONValue) -> WeatherForecastInfo {
            let date = metaData["date"].string!
            var forecastDates: [String] = []
            for i in 1...4 {
                if let forecastDate = metaData["forecast\(i)_date"].string {
                    forecastDates.append(forecastDate)
                }
            }
            return WeatherForecastInfo(date: date, forecastDates: forecastDates)
        }

        var forecastInfo: WeatherForecastInfo? = nil
        let metaData = data["results"]["meta"].first!
        if metaData {
            switch metaData {
            case .JObject:
                forecastInfo = createWeatherForecastInfo(metaData)
            case .JInvalid(let error):
                println(error)
                return
            default:
                return
            }
        }

        var locations: [WeatherForecastLocation]? = nil
        let locationsData = data["results"]["locations"]
        if locationsData {
            switch locationsData {
            case .JArray:
                locations = locationsData.array!.map { (locationData: JSONValue) -> WeatherForecastLocation in
                    return createWeatherForecastLocation(locationData)
                }
            case .JInvalid(let error):
                println(error)
                return
            default:
                return
            }
        }

        self.weatherForecast = WeatherForecast(info: forecastInfo!, locations: locations!)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weatherForecast != nil {
            return self.weatherForecast!.locations.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherForecastLocation", forIndexPath: indexPath) as WeatherForecastLocationCell

        let location = self.weatherForecast!.locations[indexPath.row]
        cell.updateWithLocation(location)

        return cell
    }
}
