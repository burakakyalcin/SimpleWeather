//
//  BaseTabBarController.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.2224404216, green: 0.6473951936, blue: 1, alpha: 1)
    }
    
    
}

