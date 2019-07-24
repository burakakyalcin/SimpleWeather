//
//  WeatherIconProvider.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//


import UIKit

class WeatherIconProvider {
    static func getWeatherImage(_ imageName: String) -> UIImage {
        switch imageName {
        case "01d":
            return #imageLiteral(resourceName: "clearSkyDay")
        case "01n":
            return #imageLiteral(resourceName: "clearSkyNight")
        case "02d":
            return #imageLiteral(resourceName: "fewCloudsDay")
        case "02n":
            return #imageLiteral(resourceName: "thunderstormNight")
        case "03d":
            return #imageLiteral(resourceName: "scatteredCloudsDay")
        case "03n":
            return #imageLiteral(resourceName: "scatteredCloudsNight")
        case "04d":
            return #imageLiteral(resourceName: "brokenCloudsDay")
        case "04n":
            return #imageLiteral(resourceName: "brokenCloudsNight")
        case "09d":
            return #imageLiteral(resourceName: "showerRainDay")
        case "09n":
            return #imageLiteral(resourceName: "showerRainNight")
        case "10d":
            return #imageLiteral(resourceName: "rainDay")
        case "10n":
            return #imageLiteral(resourceName: "rainNight")
        case "11d":
            return #imageLiteral(resourceName: "thunderstormDay")
        case "11n":
            return #imageLiteral(resourceName: "thunderstormNight")
        case "13d":
            return #imageLiteral(resourceName: "snowDay")
        case "13n":
            return #imageLiteral(resourceName: "snowNight")
        case "50d":
            return #imageLiteral(resourceName: "mistDay")
        case "50n":
            return #imageLiteral(resourceName: "mistNight")
        default:
            return #imageLiteral(resourceName: "scatteredCloudsDay")
        }
    }
}
