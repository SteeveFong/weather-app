//
//  Weather.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import SwiftUI

struct Weather: Codable, Equatable {
    let name: String?
    let datetime: Date
    let coordinate: Coordinate?
    let temperature: Temperature
    let weatherConditions: [WeatherCondition]
    
    var isFavorited = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case datetime = "dt"
        case coordinate = "coord"
        case temperature = "main"
        case weatherConditions = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name)
        
        let unixTimestamp = try container.decode(Double.self, forKey: .datetime)
        datetime = Date(timeIntervalSince1970: unixTimestamp)
        
        coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        temperature = try container.decode(Temperature.self, forKey: .temperature)
        weatherConditions = try container.decode([WeatherCondition].self, forKey: .weatherConditions)
    }
}

func ==(lhs: Weather, rhs: Weather) -> Bool {
    return lhs.name == rhs.name
}
