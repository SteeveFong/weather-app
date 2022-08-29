//
//  PlaceAutocomplete.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import Foundation

struct PlaceAutocomplete: Decodable {
    let predictions: [Place]
}

struct Place: Decodable {
    let placeId: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case description
    }
}
