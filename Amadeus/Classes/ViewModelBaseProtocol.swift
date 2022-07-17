//
//  ViewModelBaseProtocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 4/13/22.
//

import Foundation
import Combine

// MARK: BaseViewModel.
protocol ViewModelBaseProtocol {
    var loadinState : CurrentValueSubject<ViewModelStatus, Never> { get set }
    var subscriber : Set<AnyCancellable> { get }
}
