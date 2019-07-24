//
//  DirectionManager.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

class DirectionManager {
    static func getDirection(degree: Double) -> String {
        if degree < 22.5 {
            return "E"
        } else if degree < 67.5 {
            return "NE"
        } else if degree < 112.5 {
            return "N"
        } else if degree < 157.5 {
            return "NW"
        } else if degree < 202.5 {
            return "W"
        } else if degree < 247.5 {
            return "SW"
        } else if degree < 292.5 {
            return "S"
        } else if degree < 337.5{
            return "SE"
        } else {
            return "E"
        }
    }
}
