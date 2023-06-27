//
//  Cancelable.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 6/27/23.
//

import Combine

final class Cancelable {

    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in subscriber: Cancelable) {
        subscriber.subscriptions.insert(self)
    }
}
