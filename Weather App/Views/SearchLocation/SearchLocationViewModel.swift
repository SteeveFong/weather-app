//
//  SearchLocationViewModel.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import Combine
import Foundation

final class SearchLocationViewModel: ViewModelStateProtocol, ObservableObject {
    @Inject private var apiManager: ApiManager
    
    @Published var state: ViewModelState = .none
    @Published var predictions: [Place]?
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func getPlaceAutocomplete(query: String) {
        state = .isLoading
        
        cancellableSet.forEach({ $0.cancel() })
        
        apiManager.getPlaceAutocomplete(query: query)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    self?.predictions = dataResponse.value?.predictions
                } else {
                    self?.state = .error(WeatherError.noDataError.alertItem)
                }
            }.store(in: &cancellableSet)
    }
    
    func getPlaceDetails(placeId: String, success: @escaping (_ placeDetails: PlaceDetails?) -> Void) {
        state = .isLoading
        
        apiManager.getPlaceDetails(placeId: placeId)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    
                    success(dataResponse.value)
                } else {
                    self?.state = .error(WeatherError.noDataError.alertItem)
                }
            }.store(in: &cancellableSet)
    }
    
    public init () {}
}
