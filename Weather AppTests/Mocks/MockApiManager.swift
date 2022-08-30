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

class MockApiManager: ApiManagerProtocol {
    var currentWeatherData: Weather? {
        if let url = Bundle(for: MockApiManager.self).url(forResource: "weather.data", withExtension: "json") {
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
    
    var weatherForecastData: WeatherForecast? {
        if let url = Bundle(for: MockApiManager.self).url(forResource: "weather_forecast.data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                
                return try decoder.decode(WeatherForecast.self, from: data)
              } catch {
                  print("error:\(error)")
              }
        }
        
        return nil
    }
    
    var getPlaceDetails: AnyPublisher<DataResponse<PlaceDetails, AFError>, Never>!
    var getPlaceAutocomplete: AnyPublisher<DataResponse<PlaceAutocomplete, AFError>, Never>!
    var getCurrentWeather: AnyPublisher<DataResponse<Weather, AFError>, Never>!
    var getWeatherForecast: AnyPublisher<DataResponse<WeatherForecast, AFError>, Never>!
    
    func getPlaceDetails(placeId: String) -> AnyPublisher<DataResponse<PlaceDetails, AFError>, Never> {
        return getPlaceDetails
    }
    
    func getPlaceAutocomplete(query: String) -> AnyPublisher<DataResponse<PlaceAutocomplete, AFError>, Never> {
        return getPlaceAutocomplete
    }
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, AFError>, Never> {
        return getCurrentWeather
    }
    
    func getWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, AFError>, Never> {
        return getWeatherForecast
    }
}
