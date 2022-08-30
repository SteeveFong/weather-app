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
    @Inject private var apiManager: ApiManagerProtocol
    @Inject private var favoritedWeatherStore: FavoritedWeatherStoreProtocol
    
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
                    
                    if let weather = dataResponse.value,
                        let color = weather.weatherConditions.first?.conditionType.namedColor {
                        
                        self?.weatherColor = color
                        self?.favoritedWeatherStore.exists(weather: weather, completion: { result in
                            switch result {
                            case .success(_):
                                self?.currentWeather?.isFavorited = true
                            case .failure(_):
                                break
                            }
                        })
                    }
                } else {
                    self?.state = .error(WeatherError.noDataError.alertItem)
                }
            }.store(in: &cancellableSet)
    }
    
    func toggleFavorite() {
        guard let safeCurrentWeather = currentWeather else { return }
        
        favoritedWeatherStore.exists(weather: safeCurrentWeather) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let index):
                strongSelf.favoritedWeatherStore.remove(atIndex: index) { _ in
                    self?.currentWeather?.isFavorited = false
                }
            case .failure(let error):
                if error == .noDataError {
                    strongSelf.favoritedWeatherStore.save(weather: safeCurrentWeather) { _ in
                        self?.currentWeather?.isFavorited = true
                    }
                }
            }
        }
    }
    
    public init () {}
}
