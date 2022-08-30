//
//  FavoritedWeatherStore.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import Foundation
import SwiftUI

protocol FavoritedWeatherStoreProtocol {
    func load(completion: @escaping (Result<[Weather], Error>) -> Void)
    func save(favorites: [Weather], completion: @escaping (Result<Int, Error>) -> Void)
    func save(weather: Weather, completion: @escaping (Result<Int, Error>) -> Void)
    func exists(weather: Weather, completion: @escaping (Result<Int, WeatherError>) -> Void)
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void)
}

class FavoritedWeatherStore: FavoritedWeatherStoreProtocol {
    static let dataPath = "favorited_weather_store.data"
    private let store: Store<Weather>
    
    init(store: Store<Weather> = Store(path: dataPath)) {
        self.store = store
    }
    
    func load(completion: @escaping (Result<[Weather], Error>) -> Void) {
        store.load(completion: completion)
    }
    
    func save(favorites: [Weather], completion: @escaping (Result<Int, Error>) -> Void) {
        store.save(items: favorites, completion: completion)
    }
    
    func save(weather: Weather, completion: @escaping (Result<Int, Error>) -> Void) {
        store.save(item: weather, completion: completion)
    }
    
    func exists(weather: Weather, completion: @escaping (Result<Int, WeatherError>) -> Void) {
        store.load { result in
            
            switch result {
            case .success(let favorites):
                if let favoritedWeatherIndex = favorites.firstIndex(where: { $0 == weather }) {
                    completion(.success(favoritedWeatherIndex))
                } else {
                    completion(.failure(.noDataError))
                }
            case .failure(_):
                completion(.failure(.noDataError))
            }
        }
    }
    
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        store.remove(atIndex: index, completion: completion)
    }
}
