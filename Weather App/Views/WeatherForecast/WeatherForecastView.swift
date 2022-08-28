//
//  WeatherForecastView.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherForecastViewModel: WeatherForecastViewModel
    
    let margin = 14.0
    
    var body: some View {
        VStack {
            ForEach(weatherForecastViewModel.weatherForecasts ?? [], id: \.date) { weather in
                WeatherForecastRow(weather: weather)
            }
        }
        .padding(EdgeInsets(top: margin, leading: margin, bottom: margin, trailing: margin))
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
