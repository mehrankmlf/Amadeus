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
    
    private let session: SessionPublisherProtocol
    
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


public typealias AccessToken = String
public typealias RefreshToken = String

public protocol AuthenticationTokenProvidable: AnyObject {
  var accessToken: CurrentValueSubject<AccessToken?, Never> { get }
  var refreshToken: CurrentValueSubject<RefreshToken?, Never> { get }
  func reissueAccessToken() -> AnyPublisher<AccessToken, Error>
  func invalidateAccessToken()
  func invalidateRefreshToken()
}

extension AuthenticationTokenProvidable {
  func invalidateRefreshToken() {
    refreshToken.value = nil
    accessToken.value = nil
  }

  func invalidateAccesstoken() {
    accessToken.value = nil
  }
}











public enum AuthorizationHeaderScheme: String {
  case basic = "Basic "
  case bearer = "Bearer "
  case none = ""
}

public struct AuthenticatedWebServiceConfiguration {
  let authorizationHeaderScheme: AuthorizationHeaderScheme
  let refreshTriggerStatusCodes: [Int]

  public init(authorizationHeaderScheme: AuthorizationHeaderScheme = .none,
              refreshTriggerStatusCodes: [Int] = [401, 403]) {
    self.authorizationHeaderScheme = authorizationHeaderScheme
    self.refreshTriggerStatusCodes = refreshTriggerStatusCodes
  }
}

final class AuthenticatedWebService: BaseAPI<UserTokenNetworking> {
  let tokenAccessQueue = DispatchQueue(label: "com.fusion.authentication.queue")
  let executionQueue = DispatchQueue(label: "com.fusion.execution.queue",
                                     qos: .userInitiated,
                                     attributes: .concurrent)
  private let tokenProvider: AuthenticationTokenProvidable
  private let configuration: AuthenticatedWebServiceConfiguration

  public init(urlSession: SessionPublisherProtocol = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                                                delegate: nil,
                                                                delegateQueue: nil),
              tokenProvider: AuthenticationTokenProvidable,
              configuration: AuthenticatedWebServiceConfiguration = AuthenticatedWebServiceConfiguration()) {
    self.tokenProvider = tokenProvider
    self.configuration = configuration
    super.init(urlSession: urlSession)
  }

  public override func execute(urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
    var urlRequest = urlRequest

    func appendTokenAndExecute(accessToken: AccessToken) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
      urlRequest.setValue(self.configuration.authorizationHeaderScheme.rawValue + accessToken, forHTTPHeaderField: "Authorization")
      return super.execute(urlRequest: urlRequest)
        .subscribe(on: executionQueue)
        .eraseToAnyPublisher()
    }

    guard let accessToken = self.tokenProvider.accessToken.value else {
      return Deferred {
          Fail<(data: Data, response: HTTPURLResponse), Error>(error: APIError.unknownError)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
    }

    return Deferred {
      return appendTokenAndExecute(accessToken: accessToken)
        .flatMap { output -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> in
          if self.configuration.refreshTriggerStatusCodes.contains(where: { return $0 == output.response.statusCode }){
            return self.retrySynchronizedTokenRefresh()
              .flatMap { accessToken -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> in
                return appendTokenAndExecute(accessToken: accessToken)
              }
              .eraseToAnyPublisher()
          }
          return Just<(data: Data, response: HTTPURLResponse)>(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }

  private func retrySynchronizedTokenRefresh() -> AnyPublisher<AccessToken, Error> {
    return tokenProvider.reissueAccessToken()
      .subscribe(on: executionQueue,
                 options: DispatchQueue.SchedulerOptions(qos: .userInitiated, flags: .barrier))
      .handleEvents(receiveSubscription: { [weak self] _ in
        self?.tokenAccessQueue.sync {
          self?.tokenProvider.invalidateAccessToken()
        }
      },
      receiveOutput: { [weak self] (accessToken) in
        self?.tokenAccessQueue.sync {
          self?.tokenProvider.accessToken.value = accessToken
        }
      })
      .eraseToAnyPublisher()
  }
}
