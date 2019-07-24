//
//  Weather.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
