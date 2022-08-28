//
//  Date+Extensions.swift
//  Weather App
//
//  Created by Steeve on 28/08/2022.
//

import Foundation

extension Date {
    var dayOfTheWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: self)
    }
}
