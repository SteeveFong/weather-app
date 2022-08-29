//
//  SearchLocationView.swift
//  Weather App
//
//  Created by Steeve on 29/08/2022.
//

import SwiftUI

struct SearchLocationView: View {
    @State private var query = ""
    
    @Binding var selectedPlaceDetails: PlaceDetails?
    
    @ObservedObject var searchLocationViewModel = SearchLocationViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                switch searchLocationViewModel.state {
                case.isLoading:
                    Text(NSLocalizedString("LOADING", comment: "")).foregroundColor(.black)
                default:
                    List(searchLocationViewModel.predictions ?? [], id: \.placeId) { prediction in
                        Text(prediction.description)
                            .onTapGesture {
                                searchLocationViewModel.getPlaceDetails(placeId: prediction.placeId, success: { placeDetails in
                                    self.selectedPlaceDetails = placeDetails
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                            }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationTitle(NSLocalizedString("SEARCH_LOCATION", comment: ""))
            .searchable(text: $query)
            .onChange(of: query) { newValue in
                searchLocationViewModel.getPlaceAutocomplete(query: newValue)
            }
        }
    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(
            selectedPlaceDetails: .constant(
                PlaceDetails(
                    result: PlaceResult(
                        geometry: Geometry(
                            location: Location(
                                longitude: -0.1337,
                                latitude: 51.50998
                            )
                        )
                    )
                )
            )
        )
    }
}
