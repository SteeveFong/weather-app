//
//  WeatherCondition.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import SwiftUI

enum WeatherConditionType {
    case sunny
    case rainy
    case cloudy
    
    var namedColor: String {
        switch self {
        case .rainy:
            return "rainy"
        case .sunny:
            return "sunny"
        case .cloudy:
            return "cloudy"
        }
    }
}

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
}

extension WeatherCondition {
    var conditionType: WeatherConditionType {
        switch id {
        case 200...781:
            return .rainy
        case 800:
            return .sunny
        default:
            return .cloudy
        }
    }
    
    var image: Image {
        switch conditionType {
        case .rainy:
            return Image("forestRainy")
        case .sunny:
            return Image("forestSunny")
        default:
            return Image("forestCloudy")
        }
    }
    
    var label: String {
        var localizedStringKey: String
        
        switch conditionType {
        case .rainy:
            localizedStringKey = "RAINY"
        case .sunny:
            localizedStringKey = "SUNNY"
        default:
            localizedStringKey = "CLOUDY"
        }
        
        return NSLocalizedString(localizedStringKey, comment: "Simplify Weather condition")
    }
}
