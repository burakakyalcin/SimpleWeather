//
//  Sys.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    let pod: String?
}
