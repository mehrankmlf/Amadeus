//
//  NetworkClientManager.swift
//  Amadeus
//
//  Created by Mehran on 5/21/20.
//  Copyright © 2020 Mehran Kamalifard. All rights reserved.
//

import Foundation
import Combine
import os.log

public protocol SessionPublisherProtocol: AnyObject {
    func dataTaskPublisher(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}

class NetworkClientManager<Target: NetworkTarget> {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M, APIError>
    
    var subscriber = Set<AnyCancellable>()

    // The URLSession client is use to call request with URLSession Data Task Publisher
    private let clientURLSession : NetworkClientProtocol

    public init(clientURLSession : NetworkClientProtocol = NetworkClient()) {
        self.clientURLSession = clientURLSession
    }
    
    func request<M, T>(with target: Target,
                       decoder: JSONDecoder = .init(),
                       scheduler: T, responseObject type: M.Type) -> AnyPublisherResult<M> where M : Decodable, T : Scheduler {
        return clientURLSession.request(with: target, decoder: decoder, scheduler: scheduler, responseObject: type)
    }
}




