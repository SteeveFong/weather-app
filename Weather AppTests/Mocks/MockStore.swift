//
//  MockStore.swift
//  Weather AppTests
//
//  Created by Steeve on 30/08/2022.
//

import Foundation

class MockStore<T: Codable>: StoreProtocol {
    var dataResult: Result<[T], Error> = .success([])
    
    func load(completion: @escaping (Result<[T], Error>) -> Void) {
        completion(dataResult)
    }
    
    func save(items: [T], completion: @escaping (Result<Int, Error>) -> Void) {
        switch dataResult {
        case .success:
            completion(.success(items.count))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func save(item: T, completion: @escaping (Result<Int, Error>) -> Void) {
        switch dataResult {
        case .success(var items):
            items.append(item)
            
            dataResult = .success(items)
            
            completion(.success(items.count))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        switch dataResult {
        case .success(var items):
            items.remove(at: index)
            
            dataResult = .success(items)
            
            completion(.success(items.count))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
