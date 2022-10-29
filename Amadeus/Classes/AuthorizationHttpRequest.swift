//
//  AuthorizationRequest.swift
//  Amadeus
//
//  Created by Mehran on 7/8/1401 AP.
//

import Foundation
import Combine

class AuthorizationHttpRequest : AuthorizationRequestProtocol {
    
    private var subscriber = Set<AnyCancellable>()
    //    var fetchedValidToken = PassthroughSubject<Bool, Never>()
    private let queue = DispatchQueue(label: "RequestNewToken")
    
    func authenticateRequest(Completion: @escaping(Bool) -> Void)  {
        
        let credential = self.manager.getUserCredential()
        
        let request : UserTokenNetworking = .accessToken(grant_type: credential.grant_type ?? "",
                                                         client_id: credential.client_id ?? "",
                                                         client_secret: credential.client_secret ?? "")
        
        self.queue.sync {
            let requestt = request.buildURLRequest()
            requestt.dataTaskPublisher
                .retry(3)
                .map { $0.data }
                .decode(type: GetToken_Response.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sinkOnMain(receiveCompletion: { data in
                    print(data)
                    
                }, receiveValue: { token in
                    self.manager.setToken(token: token.tokenData)
                    Completion(true)
                })
                .store(in: &subscriber)
        }
    }
}

