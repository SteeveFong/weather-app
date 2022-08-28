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
        VStack(spacing: 0) {
            ZStack {
                weatherViewModel.currentWeather?
                    .weatherConditions
                    .first?
                    .image
                    .resizable()
                    .frame(minHeight: (UIScreen.main.bounds.height / 3) + UIApplication.shared.safeAreaInsets.top)
                    .scaledToFill()

                VStack(spacing: 0) {
                    Text(weatherViewModel.currentWeather?.name ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: TextSize.normal.value))
                    
                    Text.temperatureLabel(
                        degreesCelsius: weatherViewModel.currentWeather?.temperature.current,
                        size: .large)
                    .offset(x: 18)
                    
                    Text(weatherViewModel.currentWeather?.weatherConditions.first?.label.uppercased() ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: TextSize.normal.value))

                }
                .offset(y: -18)
            }
            .edgesIgnoringSafeArea(.top)
            
            HStack {
                TemperatureStack(
                    subtitle: NSLocalizedString("MIN", comment: ""),
                    temperature: weatherViewModel.currentWeather?.temperature.minimum
                )
                
                TemperatureStack(
                    subtitle: NSLocalizedString("CURRENT", comment: ""),
                    temperature: weatherViewModel.currentWeather?.temperature.current
                )
                
                TemperatureStack(
                    subtitle: NSLocalizedString("MAX", comment: ""),
                    temperature: weatherViewModel.currentWeather?.temperature.maximum
                )
            }
            .frame(height: 64)
        }
    }
}

struct TemperatureStack: View {
    let subtitle: String
    let temperature: Double?
    
    var body: some View {
        VStack {
            Text.temperatureLabel(degreesCelsius: temperature, size: .normal)
                .offset(x: 6)
            
            Text(subtitle)
                .foregroundColor(.white)
                .font(.system(size: TextSize.small.value))
        }
        .frame(maxWidth: .infinity)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
