//
//  WeatherViewModelTests.swift
//  Weather AppTests
//
//  Created by Steeve on 28/08/2022.
//

import Foundation
import Combine
import CoreLocation
import XCTest
import Alamofire

class WeatherViewModelTests: BaseTestCase {
    private lazy var apiManager: MockApiManager = injectedMock(for: ApiManager.self)
    
    private var viewModel: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = WeatherViewModel()
    }
    
    func testGetCurrentWeatherSuccess() {
        let coordinates = CLLocationCoordinate2D(latitude: 37.39, longitude: -122.08)
        let dataResponse = DataResponse<Weather, AFError>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1, result: Result.success(apiManager.currentWeatherData!))
        apiManager.getCurrentWeather = Result<DataResponse<Weather, AFError>, Never>
            .success(dataResponse)
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.getCurrentWeather(coordinate: coordinates)
        XCTAssertEqual(viewModel.currentWeather, apiManager.currentWeatherData)
    }
    
    func testGetCurrentWeatherFailure() {
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
    }
}
