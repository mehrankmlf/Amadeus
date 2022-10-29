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
    var useCase : CitySearchProtocol { get }
    func getCityData(countryCode: String, keyword: String)
}

final class MainViewModel : BaseViewModel, BaseMainViewModel {
    
    var title: String = "Amadeus"
    var useCase: CitySearchProtocol

    @Published var cityData : [CitySearchResponse]?
    
    init(useCase : CitySearchProtocol) {
        self.useCase = useCase
    }
    
    func getCityData(countryCode: String, keyword: String) {
        self.callWithProgress(argument: self.useCase.citySearchService(countryCode: countryCode, keyword: keyword)) { [weak self] data in
            guard let data = data, let cityData = data.data else {return}
            self?.cityData = cityData
        }
    }
}

