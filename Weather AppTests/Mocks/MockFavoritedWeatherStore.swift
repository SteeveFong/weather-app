//
//  MockFavoritedWeatherStore.swift
//  Weather AppTests
//
//  Created by Steeve on 30/08/2022.
//

import Foundation
import Combine

class MockFavoriteWeatherStore: FavoritedWeatherStoreProtocol {
    var store: MockStore<Weather>
    var weatherDataResult: Result<[Weather], Error> {
        return store.dataResult
    }

    init(store: MockStore<Weather> = MockStore()) {
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
        switch weatherDataResult {
        case .success(let favorites):
            
            if let index = favorites.firstIndex(where: { $0 == weather }) {
                completion(.success(index))
            } else {
                completion(.failure(.noDataError))
            }
        case .failure(_):
            completion(.failure(.noDataError))
        }
    }
    
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        store.remove(atIndex: index, completion: completion)
    }
}
