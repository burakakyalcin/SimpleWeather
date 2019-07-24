//
//  Rain.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct Rain: Codable {
    let volume: Double?
    
    enum CodingKeys: String, CodingKey {
        case volume = "3h"
    }
}
