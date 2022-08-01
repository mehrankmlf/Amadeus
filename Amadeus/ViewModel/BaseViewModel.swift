//
//  BaseViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import Foundation
import Combine

enum ViewModelStatus : Equatable {
    case loadStart
    case dismissAlert
    case emptyStateHandler(title : String, isShow : Bool)
}

protocol BaseViewModelEventSource : AnyObject {
    var loadinState : CurrentValueSubject<ViewModelStatus, Never> { get }
    var subscriber : Set<AnyCancellable> { get }
}

protocol BaseViewModelUseCase : AnyObject {
    func callWithProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void)
}

typealias StandardBaseViewModel = BaseViewModelEventSource & BaseViewModelUseCase

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
}

