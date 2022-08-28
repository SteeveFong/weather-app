//
//  ApiManager.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import Alamofire
import Combine
import CoreLocation

protocol ApiManagerProtocol {
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, AFError>, Never>
    func getWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, AFError>, Never>
}

class ApiManager: ApiManagerProtocol {    
    let sessionManager: Session = {
        var eventMonitors = [EventMonitor]()
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        #if DEBUG
        let networkLogger = NetworkLogger()
        eventMonitors.append(networkLogger)
        #endif
        
        return Session(configuration: config, eventMonitors: eventMonitors)
    }()
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, AFError>, Never> {

        return sessionManager
            .request(ApiRouter.currentWeather(coordinate: coordinate))
            .validate()
            .publishDecodable(type: Weather.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, AFError>, Never> {

        return sessionManager
            .request(ApiRouter.weatherForecast(coordinate: coordinate))
            .validate()
            .publishDecodable(type: WeatherForecast.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
