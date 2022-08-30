//
//  BaseTestCase.swift
//  Weather AppTests
//
//  Created by Steeve on 28/08/2022.
//

import Foundation
import XCTest
import Swinject
import Combine
import Alamofire

@testable import Weather_App

enum TestError: Error {
    case testCase
}

class BaseTestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        
        Injection.shared.container = buildMockContainer()
    }
    
    func injectedMock<Dependency, Mock>(for depenencyType: Dependency.Type) -> Mock {
        return Injection.shared.container.resolve(Dependency.self) as! Mock
    }
    
    private func buildMockContainer() -> Container {
        let container = Container()
        
        container.register(ApiManagerProtocol.self) { _ in
            return MockApiManager()
        }
        .inObjectScope(.container)
        
        container.register(FavoritedWeatherStoreProtocol.self) { _ in
            return MockFavoriteWeatherStore()
        }
        .inObjectScope(.container)
        
        container.register(LocationManagerProtocol.self) { _ in
            return MockLocationManager()
        }
        .inObjectScope(.container)
        
        return container
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func createPublisherDataResponse<Success, Failure>(result: Result<Success, Failure>)
        -> AnyPublisher<DataResponse<Success, Failure>, Never> {
            let dataResponse = DataResponse<Success, Failure>(
                request: nil,
                response: nil,
                data: nil,
                metrics: nil,
                serializationDuration: 1,
                result: result
            )
        
            return Result<DataResponse<Success, Failure>, Never>
                .success(dataResponse)
                .publisher
                .eraseToAnyPublisher()
    }
}
