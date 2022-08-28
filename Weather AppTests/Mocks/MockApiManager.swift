//
//  MockApiManager.swift
//  Weather AppTests
//
//  Created by Steeve on 28/08/2022.
//

import Foundation
import Combine
import Alamofire
import CoreLocation

class MockApiManager: ApiManager {
    var currentWeatherData: Weather? {
        if let url = Bundle(for: MockApiManager.self).url(forResource: "weather", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                
                return try decoder.decode(Weather.self, from: data)
              } catch {
                  print("error:\(error)")
              }
        }
        
        return nil
    }
    
    var getCurrentWeather: AnyPublisher<DataResponse<Weather, AFError>, Never>!
    var getWeatherForecast: AnyPublisher<DataResponse<WeatherForecast, AFError>, Never>!
    
    override func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, AFError>, Never> {
        return getCurrentWeather
    }
    
    override func getWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, AFError>, Never> {
        return getWeatherForecast
    }
}
