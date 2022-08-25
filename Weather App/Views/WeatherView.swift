//
//  WeatherView.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            weatherViewModel.currentWeather?
                .weatherConditions
                .first?
                .image
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 8) {
                Text.temperatureLabel(
                    degreesCelsius: weatherViewModel.currentWeather?.temperature.current ?? 0,
                    size: .large)
                
                Text(weatherViewModel.currentWeather?.weatherConditions.first?.label.uppercased() ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                
            }.offset(y: -32)
        }.frame(height: UIScreen.main.bounds.height / 3)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
