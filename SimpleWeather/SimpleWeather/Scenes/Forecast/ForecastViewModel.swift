//
//  ForecastViewModel.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

//MARK: - ForecastViewModel Protocol method prototypes
protocol ForecastViewModelProtocol: class {
    var forecast: Forecast? { get set }
    var latitude: Double? { get set }
    var longitude: Double? { get set }
    var dictionary: [Date: [ForecastItem]] { get }
    var days: [Date] { get }
    var delegate: ForecastViewModelDelegate? { get set }
    
    func getForecast()
}

//MARK: - ForecastViewModel Delegate method prototypes
protocol ForecastViewModelDelegate: class {
    func onGetForecastSucceeded()
    func onGetForecastFailed()
}

//MARK: - ForecastViewModel
class ForecastViewModel {
    
    //MARK: - Properties
    var forecast: Forecast?
    
    var latitude: Double?
    
    var longitude: Double?
    
    var dictionary = [Date: [ForecastItem]]()
    var days = [Date]()
    
    weak var delegate: ForecastViewModelDelegate?
    
    var model: ForecastModelProtocol!
    
    //MARK: - Initialization
    init() {
        model = ForecastModel()
        model.delegate = self
    }
    
}

//MARK: - ForecastModel Protocol methods.
extension ForecastViewModel: ForecastViewModelProtocol {
    
    func getForecast() {
        if let lat = latitude, let long = longitude {
            model.getForecast(lat: lat, long: long)
        } else {
            delegate?.onGetForecastFailed()
        }
    }
    
    /*
     This method creates a date array to divide tableview into days sections.
     Dictionary is needed to feed every section with hourly weather objects and days array is used to gather date objects from dictionary.
     */
    func setDictionary() {
        guard let forecastList = forecast?.list else { return }
        
        var lastDate = Date(timeIntervalSince1970: forecastList[0].dateDouble)
        
        dictionary[Date(timeIntervalSince1970: forecastList[0].dateDouble)] = [forecastList[0]]
        days.append(Date(timeIntervalSince1970: forecastList[0].dateDouble))
        
        for i in 0...forecastList.count - 2 {
            let firstDate = Date(timeIntervalSince1970: forecastList[i].dateDouble)
            let secondDate = Date(timeIntervalSince1970: forecastList[i+1].dateDouble)
            
            if firstDate.isSameDate(secondDate) {
                var values = dictionary[lastDate]
                values?.append(forecastList[i+1])
                dictionary[lastDate] = values
            } else {
                dictionary[secondDate] = [forecastList[i+1]]
                lastDate = secondDate
                days.append(secondDate)
            }
        }
        
        delegate?.onGetForecastSucceeded()
    }
}

//MARK: - ForecastModel Delegate methods.
extension ForecastViewModel: ForecastModelDelegate {
    func onGetForecastSucceeded(forecast: Forecast) {
        self.forecast = forecast
        self.setDictionary()
    }
    
    func onGetForecastFailed() {
        delegate?.onGetForecastFailed()
    }
    
}
