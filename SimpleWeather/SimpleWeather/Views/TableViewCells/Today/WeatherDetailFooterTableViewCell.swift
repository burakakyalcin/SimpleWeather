//
//  WeatherDetailFooterTableViewCell.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

//MARK: - WeatherDetailFooterTableViewCell Delegate method prototypes
protocol WeatherDetailFooterTableViewCellDelegate: class {
    func onShareTapped()
}

//MARK: - WeatherDetailFooterTableViewCell
class WeatherDetailFooterTableViewCell: UITableViewCell {
    
    weak var delegate: WeatherDetailFooterTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func shareAction(_ sender: UIButton) {
        delegate?.onShareTapped()
    }
    
}
