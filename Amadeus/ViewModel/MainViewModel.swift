//
//  MainViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import Foundation
import Combine

final class MainViewModel : ObservableObject, BaseMainViewModel {
    
    static let cellId = "cellId"
       
    @Published var hotelData : [HotelSearchResponse]?
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    var getHotels: HotelsSearchProtocol
    var title: String = "Amadeus"
    
    init(getHotels : HotelsSearchProtocol) {
        self.getHotels = getHotels
    }
    
    func getHotelsData(cityCode: String) {
        self.loadinState.send(.loadStart)
        
        self.getHotels.HotelsSearchService(cityCode: cityCode)
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
                guard let data = data, let hotels = data.data else {return}
                self?.hotelData = hotels
            }
            .store(in: &subscriber)
    }
}

