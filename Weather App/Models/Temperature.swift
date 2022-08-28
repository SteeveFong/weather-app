//
//  Temperature.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation

struct Temperature: Decodable, Equatable {
    let current: Double
    let minimum: Double?
    let maximum: Double?
    
    enum CodingKeys: String, CodingKey {
        case current = "temp"
        case minimum = "temp_min"
        case maximum = "temp_max"
    }
}

func ==(lhs: Temperature, rhs: Temperature) -> Bool {
    return lhs.current == rhs.current
    && lhs.maximum == rhs.maximum
    && lhs.minimum == rhs.minimum
}
