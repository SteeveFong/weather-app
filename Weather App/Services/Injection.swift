//
//  Injection.swift
//  Weather App
//
//  Created by Steeve on 28/08/2022.
//

import Foundation
import Swinject

final class Injection {
    static var shared = Injection()
    
    private var _container: Container?
    
    var container: Container {
        get {
            if _container == nil {
                _container = buildContainer()
            }
            
            return _container!
        }
        
        set {
            _container = newValue
        }
    }
    
    private func buildContainer() -> Container {
        let container = Container()
        
        container.register(LocationManager.self) { _ in
            return LocationManager()
        }
        
        container.register(ApiManager.self) { _ in
            return ApiManager()
        }
        
        return container
    }
}

@propertyWrapper struct Injected<T> {
    let wrappedValue: T
    
    init() {
        self.wrappedValue = Injection.shared.container.resolve(T.self)!
    }
}