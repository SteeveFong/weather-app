//
//  ContentView.swift
//  Weather App
//
//  Created by Steeve on 23/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var cancellables: Set<AnyCancellable> = []
    
    @Injected private var locationManager: LocationManager
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var weatherForecastViewModel = WeatherForecastViewModel()
    
    var body: some View {
        ZStack {
            Color(weatherViewModel.weatherColor)
                .edgesIgnoringSafeArea(.all)
            
            switch weatherViewModel.state {
            case.loaded:
                
                VStack(spacing: 0) {
                    ZStack {
                        WeatherView()
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .overlay(.white)
                    
                    WeatherForecastView()

                    Spacer()
                }
                
            default:
                Text(NSLocalizedString("LOADING", comment: "")).foregroundColor(.white)
            }
            
        }.onAppear {
            locationManager.authorizationStatus
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print("TODO handle \(completion) for error and finished completion")
                } receiveValue: { status in
                    switch status {
                    case .denied, .notDetermined, .restricted:
                        break
                    default:
                        break
                    }
                }.store(in: &cancellables)
            
            locationManager.coordinate
                .receive(on: DispatchQueue.main)
                .first(where: { $0 != nil })
                .sink { completion in
                    print("TODO handle \(completion) for error and finished completion")
                } receiveValue: { coordinate in
                    if let safeCoordinate = coordinate {
                        locationManager.stopUpdatingLocation()
                        self.weatherViewModel.getCurrentWeather(coordinate: safeCoordinate)
                        self.weatherForecastViewModel.getWeatherForecast(coordinate: safeCoordinate)
                    }
                }.store(in: &cancellables)
            
        }.environmentObject(weatherViewModel)
            .environmentObject(weatherForecastViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
