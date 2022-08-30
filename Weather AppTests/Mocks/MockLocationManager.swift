//
//  MockLocationManager.swift
//  Weather AppTests
//
//  Created by Steeve on 30/08/2022.
//

import Foundation
import CoreLocation
import Combine

class MockLocationManager: LocationManagerProtocol {
    var coordinate: PassthroughSubject<CLLocationCoordinate2D?, Error> {
        return PassthroughSubject<CLLocationCoordinate2D?, Error>()
    }
    
    var authorizationStatus: PassthroughSubject<CLAuthorizationStatus, Error> {
        return PassthroughSubject<CLAuthorizationStatus, Error>()
    }
    
    func startUpdatingLocation() {}
    
    func stopUpdatingLocation() {}
}
