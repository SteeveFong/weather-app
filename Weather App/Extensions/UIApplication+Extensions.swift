//
//  UIApplication+Extensions.swift
//  Weather App
//
//  Created by Steeve on 28/08/2022.
//

import SwiftUI

extension UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        let keyWindow = self.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap( { $0 })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first
        
        return keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
    }
}
