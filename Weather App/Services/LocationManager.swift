//
//  LocationManager.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Combine
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    var coordinate = PassthroughSubject<CLLocationCoordinate2D?, Error>()
    var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Error>()
    
    override init() {
        self.authorizationStatus.send(self.locationManager.authorizationStatus)
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        return self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        return self.locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.coordinate.send(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus.send(status)
        
        switch status {
        case .denied, .notDetermined, .restricted:
            break
        default:
            startUpdatingLocation()
        }
    }
}
