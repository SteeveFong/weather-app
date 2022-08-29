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
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(weatherForecastViewModel.weatherForecasts ?? [], id: \.date) { weather in
                    WeatherForecastRow(weather: weather)
                }
            }
            .padding(EdgeInsets(top: margin, leading: margin, bottom: margin * 10, trailing: margin))
        }
        .frame(height: UIScreen.main.bounds.height / 2)
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
