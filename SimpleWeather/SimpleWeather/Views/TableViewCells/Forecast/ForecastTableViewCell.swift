//
//  ForecastTableViewCell.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    //MARK: - UI Fields
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Helper method to set cell.
    func setCell(with model: ForecastItem) {
        let icon = model.weather.first?.icon ?? ""
        let status = model.weather.first?.description?.capitalized ?? ""
        let temperature = model.main.temp ?? 0 //Kelvin, not Celcius
        let hour = model.dateDouble
        
        weatherImageView.image = WeatherIconProvider.getWeatherImage(icon)
        weatherLabel.text = status
        temperatureLabel.text = "\(Int(temperature - 273.15))°"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: Date(timeIntervalSince1970: hour))
    }

    
}
