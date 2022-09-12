//
//  BaseAPI.swift
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

class BaseAPI<Target: NetworkTarget>: BaseAPIProtocol {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M, APIError>
    
    var debugger : BaseAPIDebuger
   
    public init(debugger : BaseAPIDebuger = BaseAPIDebuger()) {
        self.debugger = debugger
    }
    
    func request<M, T>(with target: Target,
                       decoder: JSONDecoder = .init(),
                       scheduler: T, response type: M.Type) -> AnyPublisherResult<M> where M : Decodable, T : Scheduler {
        /// Generate Specific URLRequest
        let urlRequest = target.buildURLRequest()
        return urlRequest.dataTaskPublisher
            .tryCatch { error -> URLSession.DataTaskPublisher in
                guard error.networkUnavailableReason == .constrained else {
                    let error = APIError.connectionError(error)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                return URLSession.shared.dataTaskPublisher(for: urlRequest)
            }.receive(on: scheduler)
            .tryMap { output, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = APIError.invalidResponse(httpStatusCode: 0)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                if httpResponse.statusCode == 401 {
                    
                }
                if !httpResponse.isResponseOK {
                    let error = BaseAPI.errorType(type: httpResponse.statusCode)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                /// Return response to the Usecase
                return output
            }.decode(type: type.self, decoder: decoder).mapError { error in
                if let error = error as? APIError {
                    self.debugger.log(request: urlRequest,error: error)
                    return error
                } else {
                    let error = APIError.decodingError(error)
                    self.debugger.log(request: urlRequest,error: error)
                    return error
                }
            }.eraseToAnyPublisher()
    }
}

