//
//  ContentView.swift
//  Weather App
//
//  Created by Steeve on 23/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    private let iconSize = 25.0
    
    @State var cancellables: Set<AnyCancellable> = []
    @State var selectedPlaceDetails: PlaceDetails?
    @State var isSearchScreenPresented = false
    @State var isFavoriteScreenPresented = false
    @State var alertItem: AlertItem?
    
    @Inject private var locationManager: LocationManager
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var weatherForecastViewModel = WeatherForecastViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(weatherViewModel.weatherColor)
                    .edgesIgnoringSafeArea(.all)

                switch weatherViewModel.state {
                case.loaded:

                    VStack(spacing: 0) {
                        WeatherView()

                        Divider()
                            .frame(height: 2)
                            .overlay(.white)

                        WeatherForecastView()
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
                            alertItem = WeatherError.locationPermissionDenied.alertItem
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
                
                switch weatherForecastViewModel.state {
                case .error(let item):
                    alertItem = item
                default:
                    break
                }
            }
            .alert(item: $alertItem) { alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.description,
                    dismissButton: alertItem.primaryButton
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isFavoriteScreenPresented.toggle()
                    } label: {
                        Image(systemName: "heart.text.square")
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                    }
                    .tint(.white)
                    .sheet(
                        isPresented: $isFavoriteScreenPresented,
                        onDismiss: {
                            isFavoriteScreenPresented = false
                        },
                        content: { WeatherFavoriteList() }
                    )
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {

                        Button {
                            isSearchScreenPresented.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                        }
                        .tint(.white)
                        .sheet(
                            isPresented: $isSearchScreenPresented,
                            onDismiss: {
                                isSearchScreenPresented = false
                                
                                if let location = selectedPlaceDetails?.result.geometry.location {
                                    weatherViewModel.getCurrentWeather(coordinate: location.coordinate2D)
                                }
                            },
                            content: { SearchLocationView(selectedPlaceDetails: $selectedPlaceDetails) }
                        )
                        
                        Button {
                            weatherViewModel.toggleFavorite()
                        } label: {
                            Image(systemName: weatherViewModel.currentWeather?.isFavorited ?? false ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                                .tint(weatherViewModel.currentWeather?.isFavorited ?? false ? .pink : .white)
                        }
                        .tint(.white)
                    }
                }
            }
        }
        .environmentObject(weatherViewModel)
        .environmentObject(weatherForecastViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
