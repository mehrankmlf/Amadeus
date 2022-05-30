//
//  MainViewModel.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import Foundation
import Combine

final class MainViewModel : ObservableObject, BaseMainViewModel {
    
    @Published var flightData : FlightSearchResponse?
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    var getFlightInspiration: FlightSearchProtocol
        
    init(getFlightInspiration : FlightSearchProtocol) {
        self.getFlightInspiration = getFlightInspiration
    }
    
    func getFlightInspirationData(origin: String) {
        self.loadinState.send(.loadStart)
        
        self.getFlightInspiration.flightSearchService(origin: origin)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
                }
                self?.loadinState.send(.dismissAlert)
            } receiveValue: { [weak self] data in
                self?.flightData = data
            }
            .store(in: &subscriber)
    }
}

