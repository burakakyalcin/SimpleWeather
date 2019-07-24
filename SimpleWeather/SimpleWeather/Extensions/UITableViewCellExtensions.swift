//
//  UITableViewCellExtensions.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    //Registers tableview cells to the tableview.
    static func registerSelf(_ toTableView: UITableView?) {
        let nib = UINib(nibName: self.className, bundle: nil)
        toTableView?.register(nib, forCellReuseIdentifier: self.className)
    }
    
}
