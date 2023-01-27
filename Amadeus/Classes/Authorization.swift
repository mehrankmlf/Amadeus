//
//  AuthorizationRequest.swift
//  Amadeus
//
//  Created by Mehran on 7/8/1401 AP.
//

import Foundation
import Combine

struct UserCredential : AccessTokenInjector {
    
    var userCredential : AccessTokenStore  {
        return self.manager
    }
}

struct TokenNetworking {
    
    let userCredential : AccessTokenInjector
    
    init(userCredential: AccessTokenInjector = UserCredential()) {
        self.userCredential = userCredential
    }
    
    func tokenNetworkingRequest() -> URLRequest {
        let credential = userCredential.manager.getUserCredential()
        let request : HttpRequest = .init(request: UserTokenRequest(grant_type: credential.grant_type ?? "",
                                                                       client_id: credential.client_id ?? "",
                                                                       client_secret: credential.client_secret ?? ""))
        return request.buildURLRequest()
    }
}

final class AuthorizationHttpRequest : AuthorizationRequestProtocol {
    
    private var cancellable: Cancellable?
    
    func authenticateRequest() -> Future<Bool, Never> {
        
        return Future { promise in
            let networking = TokenNetworking()
            let requestt = networking.tokenNetworkingRequest()
            self.cancellable = requestt.dataTaskPublisher
                .retry(3)
                .map { $0.data }
                .decode(type: GetToken_Response.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sinkOnMain(receiveCompletion: { completion in
                    switch completion {
                    case .failure(_):
                        promise(.success(false))
                    default : break
                    }
                }, receiveValue: { token in
                    self.manager.setToken(token: token.tokenData)
                    promise(.success(true))
                })
        }
    }
}

