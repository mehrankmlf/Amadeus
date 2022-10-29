//
//  NetworkClient.swift
//  Amadeus
//
//  Created by Mehran on 7/6/1401 AP.
//

import Foundation
import Combine

final class NetworkClient : NetworkClientProtocol {
    
    /// Initializes a new URL Session Client.
    ///
    /// - parameter urlSession: The URLSession to use.
    ///     Default: `URLSession(configuration: .shared)`.
    ///
    let session : URLSession
    let debugger : BaseAPIDebuger
    var subscriber = Set<AnyCancellable>()
    var refreshTokenSubject = PassthroughSubject<Void, Never>()
    var authorizationRequest: AuthorizationRequestProtocol
    
    init(session : URLSession = .shared, debugger : BaseAPIDebuger = BaseAPIDebuger(), authorizationRequest : AuthorizationHttpRequest = AuthorizationHttpRequest()) {
        self.session = session
        self.debugger = debugger
        self.authorizationRequest = authorizationRequest
    }
    
    @discardableResult
    func request<M, T>(with target: NetworkTarget, decoder: JSONDecoder, scheduler: T, responseObject type: M.Type) -> AnyPublisher<M, APIError> where M : Decodable, T : Scheduler {
        let urlRequest = target.buildURLRequest()
        print(urlRequest)
        print(urlRequest.allHTTPHeaderFields)
        print(urlRequest.url)
        return self.session.dataTaskPublisher(for: urlRequest)
            .tryCatch { error -> URLSession.DataTaskPublisher in
                guard error.networkUnavailableReason == .constrained else {
                    let error = APIError.connectionError(error)
                    throw error
                }
                self.debugger.log(request: urlRequest, error: error)
                return self.session.dataTaskPublisher(for: urlRequest)
            }.receive(on: scheduler)
            .tryMap { output, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = APIError.invalidResponse(httpStatusCode: 0)
                    throw error
                }
                if httpResponse.statusCode == 401 {
                    self.authorizationRequest.authenticateRequest { state in
                        if state {
                            self.request(with: target, decoder: decoder, scheduler: scheduler, responseObject: type)
                        }
                    }
                }
                if !httpResponse.isResponseOK {
                    let error = NetworkClient.errorType(type: httpResponse.statusCode)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                /// Return response to the Usecase
                return output
            }.decode(type: type.self, decoder: decoder).mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    let error = APIError.decodingError(error)
                    return error
                }
            }.eraseToAnyPublisher()
    }
}

