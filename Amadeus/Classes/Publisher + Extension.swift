//
//  Publisher + Extension.swift
//  Amadeus
//
//  Created by Mehran on 8/7/1401 AP.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    
    public func sinkOnMain(
        receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
            
            receive(on: RunLoop.main)
                .sink(receiveValue: receiveValue)
        }
}

extension Publisher {
    public func sinkOnMain(
        receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void)) -> AnyCancellable {
            
            receive(on: RunLoop.main)
                .sink(receiveCompletion: receiveCompletion, receiveValue: {_ in})
        }
}

extension Publisher {
    
    public func sinkOnMain(
        receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
        receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
            
            receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in }, receiveValue: receiveValue)
        }
}
