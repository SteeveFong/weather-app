//
//  BaseTestCase.swift
//  Weather AppTests
//
//  Created by Steeve on 28/08/2022.
//

import Foundation
import XCTest
import Swinject

@testable import Weather_App

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
        
        container.register(ApiManager.self) { _ in
            return MockApiManager()
        }
        .inObjectScope(.container)
        
        return container
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
