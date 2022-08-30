//
//  Store.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import Foundation

protocol StoreProtocol {
    associatedtype T
    
    func load(completion: @escaping (Result<[T], Error>) -> Void)
    func save(item: T, completion: @escaping (Result<Int, Error>) -> Void)
    func save(items: [T], completion: @escaping (Result<Int, Error>) -> Void)
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void)
}

class Store<T: Codable>: StoreProtocol {
    private let path: String
    
    init(path: String) {
        self.path = path
    }
    
    private func fileURL() throws -> URL {
        try FileManager
            .default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: false
            )
            .appendingPathComponent(path)
    }
    
    func load(completion: @escaping (Result<[T], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try self.fileURL()
                
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    
                    return
                }
                
                let items = try JSONDecoder().decode([T].self, from: file.availableData)
                
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func save(item: T, completion: @escaping (Result<Int, Error>) -> Void) {
        self.load { result in
            switch result {
            case .success(var items):
                items.append(item)
                self.save(items: items, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func save(items: [T], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(items)
                let outfile = try self.fileURL()
                try data.write(to: outfile)
                
                DispatchQueue.main.async {
                    completion(.success(items.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func remove(atIndex index: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        load { result in
            switch result {
            case .success(var items):
                if items.count > index {
                    items.remove(at: index)
                    
                    self.save(items: items, completion: completion)
                } else {
                    fatalError("Index \(index) cannot be greater than number of items")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
