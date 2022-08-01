//
//  MainViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import Foundation
import Combine

typealias BaseMainViewModel =  MainViewModelProtocol

protocol MainViewModelProtocol {
    var title : String { get }
    var useCase : HotelsSearchProtocol { get }
    func getHotelsData(cityCode: String)
}

final class MainViewModel : BaseViewModel, BaseMainViewModel {
    
    var title: String = "Amadeus"
    var useCase: HotelsSearchProtocol

    @Published var hotelData : [HotelSearchResponse]?
    
    init(useCase : HotelsSearchProtocol) {
        self.useCase = useCase
    }
    
    func getHotelsData(cityCode: String) {
        self.callWithProgress(argument: self.useCase.HotelsSearchService(cityCode: cityCode)) { [weak self] data in
            guard let data = data, let hotels = data.data else {return}
            self?.hotelData = hotels
        }
    }
}

