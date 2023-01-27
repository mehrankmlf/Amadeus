//
//  Retrier.swift
//  Amadeus
//
//  Created by Mehran on 8/11/1401 AP.
//

import Foundation

/// Outcome of determination whether retry is necessary.
public enum RetryResult {
    /// Retry should be attempted immediately.
    case retry
    /// Do not retry.
    case doNotRetry
}

extension RetryResult {
    var retryRequeted : Bool {
        switch self {
        case .retry : return true
        case .doNotRetry: return false
        }
    }
}

typealias RetryHandler = (URLRequest, APIError, _ completion: @escaping (RetryResult) -> Void) -> Void

protocol RequestRetrier {
    /// Determines whether the `Request` should be retried by calling the `completion` closure.
    ///
    /// This operation is fully asynchronous. Any amount of time can be taken to determine whether the request needs
    /// to be retried. The one requirement is that the completion closure is called to ensure the request is properly
    /// cleaned up after.
    ///
    /// - Parameters:
    ///   - request:    `Request` that failed due to the provided `Error`.
    ///   - session:    `Session` that produced the `Request`.
    ///   - error:      `Error` encountered while executing the `Request`.
    ///   - completion: Completion closure to be executed when a retry decision has been determined.
    func retry(_ request: URLRequest, error: APIError, completion: @escaping (RetryResult) -> Void)
}

extension RequestRetrier {
    func retry(_ request: URLRequest, error: APIError, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

class Retrier : RequestRetrier {
    
    let handler : RetryHandler
    
    init(handler: @escaping RetryHandler) {
        self.handler = handler
    }
    
    func retry(_ request: URLRequest, error: APIError, completion: @escaping (RetryResult) -> Void) {
        return handler(request, error, completion)
    }
}


