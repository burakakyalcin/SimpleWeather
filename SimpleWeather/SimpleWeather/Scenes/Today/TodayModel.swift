//
//  TodayModel.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

//MARK: - TodayModelProtocol method protoypes and properties
protocol TodayModelProtocol: class {
    var delegate: TodayModelDelegate? { get set}
    
    func getDailyWeather(lat: Double, long: Double)
}

//MARK: - TodayModelDelegate method protoypes
protocol TodayModelDelegate: class {
    func onGetDailyWeatherSucceeded(dailyWeather: DailyWeather)
    func onGetDailyWeatherFailed()
}

//MARK: - TodayModel
class TodayModel: TodayModelProtocol {
    
    //MARK: - Properties
    weak var delegate: TodayModelDelegate?
    
    var service: WeatherServiceProtocol!
    
    //MARK: - Initialization
    init() {
        service = WeatherService()
    }
    
    //MARK: - Service methods.
    func getDailyWeather(lat: Double, long: Double) {
        service.getDailyWeather(latitude: lat, longitude: long, onSuccess: { [weak self] dailyWeather in
            self?.delegate?.onGetDailyWeatherSucceeded(dailyWeather: dailyWeather)
            }, onFailure: { [weak self] in
                self?.delegate?.onGetDailyWeatherFailed()
        })
    }
}
