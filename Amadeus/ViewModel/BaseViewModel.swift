//
//  BaseViewModel.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import Foundation
import Combine

class BaseViewModel : ObservableObject {
    
    typealias LoadingState = ((ViewModelStatus) -> Void)
    
    let alertState : LoadingState? = nil
    var subscriber = Set<AnyCancellable>()
    
    func callWithProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        guard let state = alertState else {return}
        state(.loadStart)
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink { result in
                switch result {
                case .finished:
                    state(.dismissAlert)
                case .failure(let error):
                    state(.emptyStateHandler(title: error.desc, isShow: true))
                }}
    receiveValue: { data in
        callback(data)
        state(.dismissAlert)
    }
    .store(in: &subscriber)
    }
}
