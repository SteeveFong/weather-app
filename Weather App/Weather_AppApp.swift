//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Steeve on 23/08/2022.
//

import SwiftUI

@main
struct Weather_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableViewCell.appearance().backgroundColor = .clear
                    UITableView.appearance().backgroundColor = .clear
                }
        }
    }
}
