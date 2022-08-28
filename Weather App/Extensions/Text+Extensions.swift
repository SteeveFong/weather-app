//
//  Text+Extensions.swift
//  Weather App
//
//  Created by Steeve on 25/08/2022.
//

import SwiftUI

enum TextSize: CGFloat {
    case small = 18
    case normal = 24
    case large = 96
    
    var value: CGFloat {
        return self.rawValue
    }
}

extension Text {
    static func temperatureLabel(degreesCelsius: Double?, size: TextSize = .normal) -> some View {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        let stringAttrs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size.value, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        let degreesCelsiusString = degreesCelsius == nil
            ? "--"
            : String(format: "%.0f", degreesCelsius ?? 0)
        var string = AttributedString(degreesCelsiusString, attributes: stringAttrs)
        
        let symbolAttrs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size.value, weight: .ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        let symbol = AttributedString("°", attributes: symbolAttrs)
        
        string.append(symbol)

        return Text(string)
            .padding(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 0))
    }
}
