//
//  WeatherForecastViewModelTests.swift
//  Weather AppTests
//
//  Created by Steeve on 30/08/2022.
//

import Foundation
import Combine
import CoreLocation
import XCTest
import Alamofire

class WeatherForecastViewModelTests: BaseTestCase {
    private lazy var apiManager: MockApiManager = injectedMock(for: ApiManagerProtocol.self)
    
    private var viewModel: WeatherForecastViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = WeatherForecastViewModel()
    }
    
    func testGetWeatherForecastSuccess() {
        let coordinates = CLLocationCoordinate2D(latitude: 37.39, longitude: -122.08)
        let publisher: AnyPublisher<DataResponse<WeatherForecast, AFError>, Never> =
        createPublisherDataResponse(result: .success(apiManager.weatherForecastData!))

        apiManager.getWeatherForecast = publisher
        
        let forecasts = viewModel.reduceToDailyForecast(data: apiManager.weatherForecastData!)
        
        viewModel.getWeatherForecast(coordinate: coordinates)
        XCTAssertEqual(viewModel.weatherForecasts, forecasts)
    }
    
    func testGetWeatherForecastFailure() {
        let coordinates = CLLocationCoordinate2D(latitude: 37.39, longitude: -122.08)
        let publisher: AnyPublisher<DataResponse<WeatherForecast, AFError>, Never> =
        createPublisherDataResponse(result: .failure(.sessionTaskFailed(error: TestError.testCase)))

        apiManager.getWeatherForecast = publisher

        viewModel.getWeatherForecast(coordinate: coordinates)
        XCTAssertEqual(viewModel.weatherForecasts, nil)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
    }
}
