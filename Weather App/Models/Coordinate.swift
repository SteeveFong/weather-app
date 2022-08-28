//
//  Coordinate.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation

struct Coordinate: Decodable, Equatable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.longitude == rhs.longitude
    && lhs.latitude == rhs.latitude
}
