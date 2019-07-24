//
//  WeatherHeaderTableViewCell.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class WeatherHeaderTableViewCell: UITableViewCell {

    //MARK: - UI Fields
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var weatherDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Helper method to set cell.
    func setCell(with model: DailyWeather) {
        guard let name = model.name else { return }
        guard let country = model.sys?.country else { return }
        guard let degree = model.main?.temp else { return } //Kelvin, not Celcius
        guard let situation = model.weather?.first?.description?.capitalized else { return }
        guard let icon = model.weather?.first?.icon else { return }
        
        weatherImageView.image = WeatherIconProvider.getWeatherImage(icon)
        locationLabel.text = "\(name), \(country)"
        weatherDetailsLabel.text = "\(Int(degree - 273.15))°C  |  \(situation)"
    }

    
}
