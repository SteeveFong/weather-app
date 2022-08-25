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
    case currentWeather(coordinate: CLLocationCoordinate2D)
    case weatherForcast(coordinate: CLLocationCoordinate2D)
    
    var baseUrl: String {
        switch self {
        default:
            return "https://api.openweathermap.org/data/2.5"
        }
    }
    
    var apiKey: String {
        switch self {
        default:
            guard let filePath = Bundle.main.path(forResource: "APIKey-info", ofType: "plist") else {
                fatalError("Couldn't find file 'APIKey-info.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "Open Weather Api Key") as? String else {
                fatalError("Couldn't find key 'Open Weather Api Key' in 'APIKey-info.plist'")
            }
            
            return value
        }
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "/weather"
        case .weatherForcast:
            return "/forcast"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather, .weatherForcast:
            return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .currentWeather(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        case .weatherForcast(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        }
    }
    
    var defaultParameters: [String: String]? {
        switch self {
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
