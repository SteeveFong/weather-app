//
//  WeatherForecastRow.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import SwiftUI

struct WeatherForecastRow: View {
    var weather: WeatherDaily
    
    var body: some View {
        HStack {
            Text(weather.date.dayOfTheWeek)
                .foregroundColor(.white)
                .font(.system(size: TextSize.normal.value))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            weather
                .conditionIcon?
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            Text.temperatureLabel(degreesCelsius: weather.temperature, size: .normal)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 64)
    }
}

struct WeatherForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        let weather = WeatherDaily(date: .now, conditionIcon: Image("rainIcon"), temperature: 32)
        WeatherForecastRow(weather: weather)
    }
}
