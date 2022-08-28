//
//  WeatherForecast.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import Foundation

struct WeatherForecast: Decodable {
    let list: [Weather]
    let city: City
}
