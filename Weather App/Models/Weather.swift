//
//  Weather.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import SwiftUI

struct Weather: Decodable {
    let coordinate: Coordinate
    let temperature: Temperature
    let weatherConditions: [WeatherCondition]
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case temperature = "main"
        case weatherConditions = "weather"
    }
}
