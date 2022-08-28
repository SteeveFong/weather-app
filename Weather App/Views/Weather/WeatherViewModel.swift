//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import Combine
import Foundation
import CoreLocation

final class WeatherViewModel: ViewModelStateProtocol, ObservableObject {
    @Injected private var apiManager: ApiManager
    
    @Published var state: ViewModelState = .none
    @Published var currentWeather: Weather?
    @Published var weatherColor = WeatherConditionType.cloudy.namedColor
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) {
        state = .isLoading
        
        apiManager.getCurrentWeather(coordinate: coordinate)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    self?.currentWeather = dataResponse.value
                    
                    if let color = dataResponse.value?.weatherConditions.first?.conditionType.namedColor {
                        self?.weatherColor = color
                    }                    
                } else {
                    self?.state = .error(title: "tset", description: "awfewef")
                }
            }.store(in: &cancellableSet)
    }
}
