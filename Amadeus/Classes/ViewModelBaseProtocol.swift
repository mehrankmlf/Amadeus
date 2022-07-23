//
//  ViewModelBaseProtocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 4/13/22.
//

import Foundation
import Combine

enum ViewModelStatus : Equatable {
    case loadStart
    case dismissAlert
    case emptyStateHandler(title : String, isShow : Bool)
}

// MARK: BaseViewModel.
protocol ViewModelBaseProtocol {
    var loadinState : CurrentValueSubject<ViewModelStatus, Never> { get set }
    var subscriber : Set<AnyCancellable> { get }
}
