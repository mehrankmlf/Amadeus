//
//  ViewModelsProtocols.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 2/27/22.
//

import UIKit
import Combine

// MARK: LoginViewModel.
typealias BaseLoginViewModel = ViewModelBaseProtocol & LogiViewModel

protocol LogiViewModel {
    var getTokenService : GetTokenProtocol { get }
    func getTokenData(grant_type: String, client_id: String, client_secret: String)
}

// MARK: MainViewModel.
typealias BaseMainViewModel = ViewModelBaseProtocol & MainViewModelInput & MainViewModelProtocol

protocol MainViewModelInput {
    var title : String { get }
}

protocol MainViewModelProtocol {
    var getHotels : HotelsSearchProtocol { get }
    func getHotelsData(cityCode: String)
}
