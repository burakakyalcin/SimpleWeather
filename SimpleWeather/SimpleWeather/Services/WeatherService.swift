//
//  DailyWeatherService.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]

protocol WeatherServiceProtocol: class {
    func getDailyWeather(latitude: Double, longitude: Double, onSuccess: @escaping (DailyWeather) -> Void , onFailure: @escaping () -> Void)
    func getForecast(latitude: Double, longitude: Double, onSuccess: @escaping (Forecast) -> Void , onFailure: @escaping () -> Void)
}

class WeatherService: WeatherServiceProtocol {
    
    func getDailyWeather(latitude: Double, longitude: Double, onSuccess: @escaping (DailyWeather) -> Void , onFailure: @escaping () -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=ea2d8ade8074b377463a35da1ce64e47"
        guard let url = URL(string: urlString) else {
            onFailure()
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            do {
                guard let data = response.data else { return }
                let response = try JSONDecoder().decode(DailyWeather.self, from: data)
                onSuccess(response)
            } catch {
                onFailure()
            }
        }
    }
    
    func getForecast(latitude: Double, longitude: Double, onSuccess: @escaping (Forecast) -> Void , onFailure: @escaping () -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=ea2d8ade8074b377463a35da1ce64e47"
        guard let url = URL(string: urlString) else {
            onFailure()
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            do {
                guard let data = response.data else { return }
                let response = try JSONDecoder().decode(Forecast.self, from: data)
                onSuccess(response)
            } catch {
                onFailure()
            }
        }
    }
    
}
