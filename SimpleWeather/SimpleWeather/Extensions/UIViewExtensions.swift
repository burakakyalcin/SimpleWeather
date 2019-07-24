//
//  UIViewExtensions.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

public extension UIView {
    
    //Instead of writing class name in quotes, this way is safer.
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}

