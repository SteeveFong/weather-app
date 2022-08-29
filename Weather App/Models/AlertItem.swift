//
//  AlertItem.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title = Text("")
    var description: Text?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
}
