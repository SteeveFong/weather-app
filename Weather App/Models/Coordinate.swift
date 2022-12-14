//
//  Coordinate.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import CoreLocation

struct Coordinate: Codable, Equatable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

extension Coordinate {
    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.longitude == rhs.longitude
    && lhs.latitude == rhs.latitude
}
