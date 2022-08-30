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
    private lazy var apiManager: MockApiManager = injectedMock(for: ApiManagerProtocol.self)
    private lazy var favoritedWeatherStore: MockFavoriteWeatherStore = injectedMock(for: FavoritedWeatherStoreProtocol.self)
    
    private var viewModel: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = WeatherViewModel()
    }
    
    func testGetCurrentWeatherSuccess() {
        let coordinates = CLLocationCoordinate2D(latitude: 37.39, longitude: -122.08)
        let publisher: AnyPublisher<DataResponse<Weather, AFError>, Never> =
            createPublisherDataResponse(result: .success(apiManager.currentWeatherData!))

        apiManager.getCurrentWeather = publisher
        
        viewModel.getCurrentWeather(coordinate: coordinates)
        XCTAssertEqual(viewModel.currentWeather, apiManager.currentWeatherData)
    }
    
    func testGetCurrentWeatherFailure() {
        let coordinates = CLLocationCoordinate2D(latitude: 37.39, longitude: -122.08)
        let publisher: AnyPublisher<DataResponse<Weather, AFError>, Never> =
        createPublisherDataResponse(result: .failure(.sessionTaskFailed(error: TestError.testCase)))

        apiManager.getCurrentWeather = publisher
        
        viewModel.getCurrentWeather(coordinate: coordinates)
        XCTAssertEqual(viewModel.currentWeather, nil)
    }
    
    func testFavoriteToggle() {
        var currentWeather = apiManager.currentWeatherData
        currentWeather?.isFavorited = false
        
        switch favoritedWeatherStore.weatherDataResult {
        case .success(let favorites):
            XCTAssertTrue(favorites.count == 0)
        case .failure(_):
            fatalError("weatherDataResult should not return failure")
        }
        
        viewModel.currentWeather = currentWeather
        viewModel.toggleFavorite()
        XCTAssertTrue(viewModel.currentWeather!.isFavorited)
        
        switch favoritedWeatherStore.weatherDataResult {
        case .success(let favorites):
            XCTAssertTrue(favorites.count == 1)
            XCTAssertEqual(favorites.first, viewModel.currentWeather)
        case .failure(_):
            fatalError("weatherDataResult should not return failure")
        }
        
        // toggle one more time
        viewModel.toggleFavorite()
        XCTAssertFalse(viewModel.currentWeather!.isFavorited)
        
        switch favoritedWeatherStore.weatherDataResult {
        case .success(let favorites):
            XCTAssertTrue(favorites.count == 0)
        case .failure(_):
            fatalError("weatherDataResult should not return failure")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
    }
}
