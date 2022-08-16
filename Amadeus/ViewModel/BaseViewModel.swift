//
//  BaseViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import Foundation
import Combine

open class BaseViewModel : StandardBaseViewModel {
    
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    
    func callWithProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        self.loadinState.send(.loadStart)
        
        let completionHandler: (Subscribers.Completion<APIError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.loadinState.send(.dismissAlert)
                self?.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
            case .finished:
                self?.loadinState.send(.dismissAlert)
            }
        }
        
        let resultValueHandler: (ReturnType?) -> Void = { data in
            callback(data)
        }
        
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink(receiveCompletion: completionHandler, receiveValue: resultValueHandler)
            .store(in: &subscriber)
    }
    
    func callWithoutProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        
        let resultValueHandler: (ReturnType?) -> Void = { data in
            callback(data)
        }
        
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink(receiveCompletion: {_ in }, receiveValue: resultValueHandler)
            .store(in: &subscriber)
    }
}

