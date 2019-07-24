//
//  TodayViewModel.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//


import Foundation

//MARK: - TodayViewModel Protocol method prototypes
protocol TodayViewModelProtocol: class {
    var dailyWeather: DailyWeather? { get set }
    var latitude: Double? { get set }
    var longitude: Double? { get set }
    var delegate: TodayViewModelDelegate? { get set }
    
    func getDailyWeather()
}

//MARK: - TodayViewModel Delegate method prototypes
protocol TodayViewModelDelegate: class {
    func onGetDailyWeatherSucceeded()
    func onGetDailyWeatherFailed()
}

//MARK: - TodayViewModel
class TodayViewModel {
    
    //MARK: - Properties
    var dailyWeather: DailyWeather?
    var latitude: Double?
    var longitude: Double?
    
    weak var delegate: TodayViewModelDelegate?
    
    var model: TodayModelProtocol!
    
    //MARK: - Initialization
    init() {
        model = TodayModel()
        model.delegate = self
    }
}

//MARK: - TodayViewModel Protocol methods
extension TodayViewModel: TodayViewModelProtocol {
    func getDailyWeather() {
        if let lat = latitude, let long = longitude {
            model.getDailyWeather(lat: lat, long: long)
        } else {
            delegate?.onGetDailyWeatherFailed()
        }
    }
}

//MARK: - TodayModel Delegate methods
extension TodayViewModel: TodayModelDelegate {
    func onGetDailyWeatherSucceeded(dailyWeather: DailyWeather) {
        self.dailyWeather = dailyWeather
        delegate?.onGetDailyWeatherSucceeded()
    }
    
    func onGetDailyWeatherFailed() {
        delegate?.onGetDailyWeatherFailed()
    }
    
}

