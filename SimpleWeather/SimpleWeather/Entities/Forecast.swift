//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}

struct ForecastItem: Codable {
    let dateDouble: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds?
    let wind: Wind?
    let rain: Rain?
    let sys: Sys?
    let dateText: String
    
    enum CodingKeys: String, CodingKey {
        case dateDouble = "dt"
        case main
        case weather
        case clouds
        case wind
        case rain
        case sys
        case dateText = "dt_txt"
    }
    
}
