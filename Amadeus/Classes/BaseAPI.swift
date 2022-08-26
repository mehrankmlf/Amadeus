//
//  BaseAPI.swift
//  Amadeus
//
//  Created by Mehran on 5/21/20.
//  Copyright © 2020 Mehran Kamalifard. All rights reserved.
//

import Foundation
import Combine

class BaseAPI: HoverProtocol {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M, APIError>

    private let debugger : BaseAPIDebuger

    // MARK: Object Lifecycle
    public init(debugger : BaseAPIDebuger = BaseAPIDebuger()) {
        self.debugger = debugger
    }

    func request<M, T>(with target: NetworkTarget,
                       urlSession: URLSession = URLSession.shared,
                       jsonDecoder: JSONDecoder = .init(),
                       scheduler: T, class type: M.Type) -> AnyPublisherResult<M> where M : Decodable, T : Scheduler {
        let urlRequest = constructURL(with: target)
   
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryCatch { error -> URLSession.DataTaskPublisher in
                guard error.networkUnavailableReason == .constrained else {
                    let error = APIError.connectionError(error)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                return urlSession.dataTaskPublisher(for: urlRequest)
            }.receive(on: DispatchQueue.main)
            .tryMap { output, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = APIError.invalidResponse(httpStatusCode: 0)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }

                if !httpResponse.isSuccessful {
                    let error = APIError.invalidResponse(httpStatusCode: httpResponse.statusCode)
                    self.debugger.log(request: urlRequest,error: error)
                    throw error
                }
                return output
            }.decode(type: type.self, decoder: jsonDecoder).mapError { error in
                if let error = error as? APIError {
                    self.debugger.log(request: urlRequest,error: error)
                    return error
                } else {
                    let err = APIError.decodingError(error)
                    self.debugger.log(request: urlRequest,error: error)
                    return err
                }
            }.eraseToAnyPublisher()
    }
}

// MARK: - Private Extension
extension BaseAPI {
    func constructURL(with target: NetworkTarget) -> URLRequest {
        switch target.methodType {
        case .get:
            return prepareGetRequest(with: target)
        case .put,
                .post:
            return prepareGeneralRequest(with: target)
        case .delete:
            return prepareDeleteRequest(with: target)
        }
    }
    
    func prepareGetRequest(with target: NetworkTarget) -> URLRequest {
        let url = target.pathAppendedURL
        switch target.task {
        case .requestParameters(let parameters, _):
            guard let contentType = target.contentType,
                  contentType == .urlFormEncoded else {
                let url = url.generateUrlWithQuery(with: parameters)
                var request = URLRequest(url: url)
                request.prepareRequest(with: target)
                return request
            }
            var request = URLRequest(url: url)
            request.httpBody = contentType.prepareContentBody(parameters: parameters)
            return request
        default:
            var request = URLRequest(url: url)
            request.prepareRequest(with: target)
            return request
        }
    }
    
    func prepareGeneralRequest(with target: NetworkTarget) -> URLRequest {
        let url = target.pathAppendedURL
        var request = URLRequest(url: url)
        request.prepareRequest(with: target)
        switch target.task {
        case .requestParameters(let parameters, _):
            request.httpBody = target.contentType?.prepareContentBody(parameters: parameters)
            return request
        default:
            return request
        }
    }
    
    func prepareDeleteRequest(with target: NetworkTarget) -> URLRequest {
        let url = target.pathAppendedURL
        switch target.task {
        case .requestParameters(let parameters, _):
            var request = URLRequest(url: url)
            request.prepareRequest(with: target)
            request.httpBody = target.contentType?.prepareContentBody(parameters: parameters)
            return request
        default:
            var request = URLRequest(url: url)
            request.httpMethod = target.methodType.name
            return request
        }
    }
}

