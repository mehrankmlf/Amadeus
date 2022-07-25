//
//  MainViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import Foundation
import Combine

typealias BaseMainViewModel = ViewModelBaseProtocol &
                              MainViewModelInput &
                              MainViewModelProtocol

protocol MainViewModelInput {
    var title : String { get }
}

protocol MainViewModelProtocol {
    var useCase : HotelsSearchProtocol { get }
    func getHotelsData(cityCode: String)
}

final class MainViewModel : ObservableObject, BaseMainViewModel {
    
    var title: String = "Amadeus"
    var useCase: HotelsSearchProtocol
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
   
    @Published var hotelData : [HotelSearchResponse]?
    
    init(useCase : HotelsSearchProtocol) {
        self.useCase = useCase
    }
    
    func getHotelsData(cityCode: String) {
        self.loadinState.send(.loadStart)
        
        self.useCase.HotelsSearchService(cityCode: cityCode)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    self?.loadinState.send(.dismissAlert)
                case .failure(let error):
                    self?.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
                }
            } receiveValue: { [weak self] data in
                self?.loadinState.send(.dismissAlert)
                guard let data = data, let hotels = data.data else {return}
                self?.hotelData = hotels
            }
            .store(in: &subscriber)
    }
}

