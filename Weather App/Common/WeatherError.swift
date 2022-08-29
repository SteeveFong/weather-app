//
//  WeatherError.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import SwiftUI

enum WeatherError: Error {
    case noDataError
    case locationPermissionDenied
}

extension WeatherError {
    var alertItem: AlertItem {
        switch self {
        case .noDataError:
            return AlertItem(
                description: Text(NSLocalizedString("NO_DATA_FOUND", comment: "")),
                primaryButton: .default(Text(NSLocalizedString("OK", comment: ""))))
        case .locationPermissionDenied:
            return AlertItem(
                description: Text(NSLocalizedString("LOCATION_PERMISSION_DENIED", comment: "")),
                primaryButton: .default(Text(NSLocalizedString("OK", comment: ""))))
        }
    }
}
