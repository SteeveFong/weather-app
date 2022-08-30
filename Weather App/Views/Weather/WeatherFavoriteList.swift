//
//  WeatherFavoriteList.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import SwiftUI

struct WeatherFavoriteList: View {
    @State var weatherFavorites: [Weather] = []
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @Inject var favoritedWeatherStore: FavoritedWeatherStoreProtocol
    
    var body: some View {
        NavigationView {
            List(weatherFavorites, id: \.name) { weather in
                Text(weather.name ?? "")
                    .onTapGesture {
                        if let coordinate = weather.coordinate?.coordinate2D {
                            weatherViewModel.getCurrentWeather(coordinate: coordinate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .navigationTitle(NSLocalizedString("WEATHER_FAVORITES", comment: ""))
            .onAppear {
                favoritedWeatherStore.load { result in
                    switch result {
                    case .success(let favorites):
                        self.weatherFavorites = favorites
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}

struct WeatherFavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherFavoriteList()
    }
}
