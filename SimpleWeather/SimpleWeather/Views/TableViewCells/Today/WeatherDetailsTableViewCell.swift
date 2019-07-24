//
//  WeatherDetailsTableViewCell.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {

    //MARK: - UI Fields
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var precipitationLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //Helper method to set cell.
    func setCell(with model: DailyWeather) {
        humidityLabel.text = "\(Int(model.main?.humidity ?? 0))%"
        pressureLabel.text = "\(Int(model.main?.pressure ?? 0)) hPa"
        windSpeedLabel.text = "\(model.wind?.speed ?? 0) km/h"
        windDirectionLabel.text = "\(DirectionManager.getDirection(degree: model.wind?.deg ?? 0))"
        precipitationLabel.text = "\(model.rain?.volume ?? 0) mm"
    }
    
}
