//
//  ApiRouter.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Foundation
import Alamofire
import CoreLocation

enum ApiRouter {
    case placeDetails(placeId: String)
    case placeAutocomplete(query: String)
    case currentWeather(coordinate: CLLocationCoordinate2D)
    case weatherForecast(coordinate: CLLocationCoordinate2D)
    
    var baseUrl: String {
        switch self {
        case .placeDetails, .placeAutocomplete:
            return "https://maps.googleapis.com/maps/api"
        default:
            return "https://api.openweathermap.org/data/2.5"
        }
    }
    
    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "APIKey-info", ofType: "plist") else {
            fatalError("Couldn't find file 'APIKey-info.plist'")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        switch self {
        case .placeDetails, .placeAutocomplete:
            guard let value = plist?.object(forKey: "Google Places Api Key") as? String else {
                fatalError("Couldn't find key 'Google Places Api Key' in 'APIKey-info.plist'")
            }
            
            return value
        default:
            guard let value = plist?.object(forKey: "Open Weather Api Key") as? String else {
                fatalError("Couldn't find key 'Open Weather Api Key' in 'APIKey-info.plist'")
            }
            
            return value
        }
    }
    
    var path: String {
        switch self {
        case .placeDetails:
            return "/place/details/json"
        case .placeAutocomplete:
            return "/place/autocomplete/json"
        case .currentWeather:
            return "/weather"
        case .weatherForecast:
            return "/forecast"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .placeDetails, .placeAutocomplete, .currentWeather, .weatherForecast:
            return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .placeDetails(let placeId):
            return [
                "fields": "geometry",
                "place_id": placeId
            ]
        case .placeAutocomplete(let query):
            return [
                "input": query,
                "types": "(cities)"
            ]
        case .currentWeather(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        case .weatherForecast(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        }
    }
    
    var defaultParameters: [String: String]? {
        switch self {
        case .placeDetails, .placeAutocomplete:
            return [
                "key": apiKey
            ]
        default:
            return [
                "appid": apiKey,
                "units": "metric"
            ]
        }
    }
}

// MARK: - URLRequestConvertible
extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
              .encode(parameters, into: request)
        }
        
        if let defaultParams = defaultParameters {
            request = try URLEncodedFormParameterEncoder()
              .encode(defaultParams, into: request)
        }
        
        return request
    }
}
