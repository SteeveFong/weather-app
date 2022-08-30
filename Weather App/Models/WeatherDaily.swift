//
//  WeatherDaily.swift
//  Weather App
//
//  Created by Steeve on 27/08/2022.
//

import Foundation
import SwiftUI

struct WeatherDaily: Equatable {
    let date: Date
    let conditionIcon: Image?
    let temperature: Double
}

func ==(lhs: WeatherDaily, rhs: WeatherDaily) -> Bool {
    return lhs.date == rhs.date
    && lhs.conditionIcon == rhs.conditionIcon
    && lhs.temperature == rhs.temperature
}
