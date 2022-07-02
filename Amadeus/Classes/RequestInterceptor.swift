//
//  RequestInterceptor.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 5/23/22.
//

import UIKit
import Alamofire

final class RequestInterceptorHelper : Alamofire.RequestInterceptor, KeyChainManagerInjector, RequestInterceptorProtocol {
    
    var retryLimit: Int = 3
    var isRetrying: Bool = false
    var retryDelay: TimeInterval = 2
    weak var requestNewToken : RequestNewToken?
    
    init(requestNewTOken : RequestNewToken) {
        self.requestNewToken = requestNewTOken
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        guard let token = self.keychainManager.getToken() else {
            /// Set the Authorization header value using the access token.
            completion(.success(urlRequest))
            return
        }
        
        if urlRequest.url?.absoluteString.hasPrefix("https://test.api.amadeus.com/v1/security/oauth2/token") == false {
            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        if request.retryCount < self.retryLimit {
            
            switch statusCode {
            case 200...299 :
                completion(.doNotRetry)
            case 401 :
                if !isRetrying {
                    self.requestNewToken.refreshToken { isSuccess in
                        isSuccess ? completion(.retry) : completion(.doNotRetry)
                    }
                }else{
                    completion(.doNotRetry)
                }
            case 500...599 :
                return completion(.retryWithDelay(self.retryDelay))
            default:
                completion(.doNotRetry)
            }
            
        } else {
            session.cancelAllRequests()
            completion(.doNotRetryWithError(APIError.serverError))
        }
    }
}




