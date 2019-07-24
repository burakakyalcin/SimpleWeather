//
//  City.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coordinate?
    let country: String?
}
