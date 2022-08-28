//
//  WeatherForecastViewModel.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import Combine
import Foundation
import CoreLocation

final class WeatherForecastViewModel: ViewModelStateProtocol, ObservableObject {
    @Injected private var apiManager: ApiManager
    
    @Published var state: ViewModelState = .none
    @Published var weatherForecasts: [WeatherDaily]?
    
    private var cancellableSet: Set<AnyCancellable> = []

    func getWeatherForecast(coordinate: CLLocationCoordinate2D) {
        state = .isLoading
        
        apiManager.getWeatherForecast(coordinate: coordinate)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    self?.weatherForecasts = self?.reduceToDailyForecast(data: dataResponse.value)
                } else {
                    self?.state = .error(title: "tset", description: "awfewef")
                }
            }.store(in: &cancellableSet)
    }
    
    func reduceToDailyForecast(data: WeatherForecast?) -> [WeatherDaily] {
        var currentDay = ""
        var results = [WeatherDaily]()
        
        // take first weather forecast for each day
        for weather in data?.list ?? [] {
            if currentDay != weather.datetime.dayOfTheWeek {
                currentDay = weather.datetime.dayOfTheWeek
                
                results.append(
                    WeatherDaily(
                        date: weather.datetime,
                        conditionIcon: weather.weatherConditions.first?.icon,
                        temperature: weather.temperature.current
                    )
                )
            }
        }
        
        // quick fix, return only 5 days forecast
        if results.count > 5 {
            return results.suffix(5)
        }
        
        return results
    }
}
