//
//  Coordinate.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation

struct Coordinate: Decodable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
