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

        self.reloadForecast(nil)
    }

    func reloadForecast(completion: ((NSError?) -> Void)?) {
        let apiURL = NSURL(string: "http://ff14angler.com/skywatcher.php")
        NSURLSession.sharedSession().dataTaskWithURL(apiURL!, completionHandler: {
            (data, response, error) in
            if error != nil {
                completion?(error)
                return
            }

            self.parseForecast(JSON(data: data))

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.navigationItem.title = self.weatherForecast?.date

                completion?(nil)
            })
        }).resume()
    }

    func parseForecast(data: JSON) {
        let date = String(format: "ET %02d:%02d (残り時間 %02d:%02d)", arguments: [data["hour"].integerValue!, data["minute"].integerValue!, data["left_hour"].integerValue!, data["left_minute"].integerValue!])

        var locations = Location.allValues.map { (location: Location) -> WeatherForecastLocation in
            return WeatherForecastLocation(location: location, forecasts: [Weather](count: 5, repeatedValue: Weather.不明))
        }

        if let forecasts = data["data"].arrayValue {
            for forecast in forecasts {
                let time = forecast["time"].integerValue! + 1
                let area = forecast["area"].integerValue!
                let location = Location(rawValue:area)
                let weather = Weather(rawValue:forecast["weather"].integerValue!)

                var newForecasts = locations[area - 1].forecasts
                newForecasts[time] = weather!
                locations[area - 1] = WeatherForecastLocation(location: location!, forecasts: newForecasts)
            }
        }

        self.weatherForecast = WeatherForecast(date: date, locations: locations)
    }

    @IBAction func didRequestRefresh(sender: AnyObject) {
        let refreshControl = sender as UIRefreshControl
        refreshControl.beginRefreshing()

        self.reloadForecast({
            (error) in
            if (refreshControl.refreshing) {
                refreshControl.endRefreshing()
            }
        })
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
