//
//  City.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import Foundation

struct City: Decodable, Identifiable {
    let id: Int
    let name: String
    let country: String
    let coordinate: Coordinate
    let sunrise: Date
    let sunset: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, country, sunrise, sunset
        case coordinate = "coord"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        
        let sunriseUnixTimestamp = try container.decode(Double.self, forKey: .sunrise)
        sunrise = Date(timeIntervalSince1970: sunriseUnixTimestamp)
        
        let sunsetUnixTimestamp = try container.decode(Double.self, forKey: .sunset)
        sunset = Date(timeIntervalSince1970: sunsetUnixTimestamp)
    }
}
