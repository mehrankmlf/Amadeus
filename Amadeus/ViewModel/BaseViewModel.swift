//
//  BaseViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import Foundation
import Combine

protocol BaseViewModelEventSource : AnyObject {
    var loadinState : CurrentValueSubject<ViewModelStatus, Never> { get }
}

class BaseViewModel : BaseViewModelEventSource {
    
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    
    func callWithProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        self.loadinState.send(.loadStart)
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink { result in
                switch result {
                case .finished:
                    self.loadinState.send(.dismissAlert)
                case .failure(let error):
                    self.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
                }}
    receiveValue: { data in
        callback(data)
        self.loadinState.send(.dismissAlert)
    }
    .store(in: &subscriber)
    }
}
