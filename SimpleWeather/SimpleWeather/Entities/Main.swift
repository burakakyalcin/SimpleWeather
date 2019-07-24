//
//  Main.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct Main: Codable {
    let temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Double?
    let seaLevel: Double?
    let groundLevel: Double?
    let tempKF: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case tempKF = "temp_kf"
    }
}

