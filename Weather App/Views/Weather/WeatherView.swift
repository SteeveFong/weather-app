//
//  WeatherView.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    let containerHeight = UIScreen.main.bounds.height / 3
    
    var body: some View {
        VStack(spacing: 0) {
            
            weatherViewModel.currentWeather?
                .weatherConditions
                .first?
                .image
                .resizable()
                .frame(width: UIScreen.main.bounds.width)
                .scaledToFill()
                .overlay(
                    VStack(spacing: 0) {
                        Text(weatherViewModel.currentWeather?.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: TextSize.normal.value))

                        Text.temperatureLabel(
                            degreesCelsius: weatherViewModel.currentWeather?.temperature.current,
                            size: .large)
                        .offset(x: 16)

                        Text(weatherViewModel.currentWeather?.weatherConditions.first?.label.uppercased() ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: TextSize.normal.value))

                    }
                    .offset(y: -18)
                )
            
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
            .frame(height: 58)
        }
        .edgesIgnoringSafeArea(.top)
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
