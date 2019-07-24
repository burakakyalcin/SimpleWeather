//
//  ForecastModel.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

//MARK: - ForecastModelProtocol method protoypes and properties
protocol ForecastModelProtocol: class {
    var delegate: ForecastModelDelegate? { get set}
    
    func getForecast(lat: Double, long: Double)
}

//MARK: - ForecastModelDelegate method protoypes
protocol ForecastModelDelegate: class {
    func onGetForecastSucceeded(forecast: Forecast)
    func onGetForecastFailed()
}

//MARK: - Forecast
class ForecastModel: ForecastModelProtocol {
    
    //MARK: - Properties
    weak var delegate: ForecastModelDelegate?
    
    var service: WeatherServiceProtocol!
    
    //MARK: - Initialization
    init() {
        service = WeatherService()
    }
    
    //MARK: - Service methods.
    func getForecast(lat: Double, long: Double) {
        service.getForecast(latitude: lat, longitude: long, onSuccess: { [weak self] forecast in
            self?.delegate?.onGetForecastSucceeded(forecast: forecast)
            }, onFailure: { [weak self] in
                self?.delegate?.onGetForecastFailed()
        })
    }
}
