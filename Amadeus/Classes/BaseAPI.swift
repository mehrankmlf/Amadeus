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

class BaseAPI: BaseAPIProtocol {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M, APIError>
    
    private let debugger : BaseAPIDebuger
    
    public init(debugger : BaseAPIDebuger = BaseAPIDebuger()) {
        self.debugger = debugger
    }
    
    func request<M, T>(with target: NetworkTarget,
                       decoder: JSONDecoder = .init(),
                       scheduler: T, response type: M.Type) -> AnyPublisherResult<M> where M : Decodable, T : Scheduler {
        /// Generate Specific URLRequest
                let urlRequest = request(with: target)
//        let urlRequest = constructURL(with: target)
        //        print(urlRequest)
        //        print(urlRequest.url)
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
                if !httpResponse.isResponseOK {
                    let error = APIError.invalidResponse(httpStatusCode: httpResponse.statusCode)
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
                    let err = APIError.decodingError(error)
                    self.debugger.log(request: urlRequest,error: error)
                    return err
                }
            }.eraseToAnyPublisher()
    }
}

// MARK: - Private Extension
extension BaseAPI {
    
    func request(with type : NetworkTarget) -> URLRequest {
        let request = try! URLRequestBuilder(path: type.path)
            .method(.post)
        //            .jsonBody(type.parameters)
            .contentType(.applicationXWwwFormUrlEncoded)
        //            .accept(.applicationJSON)
            .timeout(20)
        //            .acceptEncoding(<#T##encoding: URLRequestBuilder.Encoding##URLRequestBuilder.Encoding#>)

            .queryItems(type.parameters)
            .makeRequest(withBaseURL: type.baseURL.desc)
        return request
    }
    
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
