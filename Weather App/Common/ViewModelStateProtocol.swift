//
//  ViewModelStateProtocol.swift
//  Weather App
//
//  Created by Steeve on 26/08/2022.
//

import Foundation

enum ViewModelState {
    case none
    case loaded
    case isLoading
    case error(_ item: AlertItem)
}

protocol ViewModelStateProtocol {
    var state: ViewModelState { get }
}
