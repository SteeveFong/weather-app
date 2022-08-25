//
//  Text+Extensions.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import SwiftUI

enum TextSize: CGFloat {
    case small = 24
    case large = 64
}

extension Text {
    static func temperatureLabel(degreesCelsius: Double, size: TextSize = .small) -> some View {
        let stringAttrs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size.rawValue, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        var string = AttributedString(String(format: "%.0f", degreesCelsius), attributes: stringAttrs)
        
        let symbolAttrs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size.rawValue, weight: .ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        let symbol = AttributedString("°", attributes: symbolAttrs)
        
        string.append(symbol)

        return Text(string)
    }
}
