//
//  RequestNewToken.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/2/22.
//

import Foundation
import Alamofire
import Combine

protocol RequestNewTokenProtocol  {
    var getTokenService : GetTokenProtocol { get }
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void)
}

 final class RequestNewToken : RequestNewTokenProtocol, KeyChainManagerInjector {
    
    var getTokenService: GetTokenProtocol
    var subscriber = Set<AnyCancellable>()
     
     init(getTokenService: GetTokenProtocol = GetToken_Request()) {
         self.getTokenService = getTokenService
     }
    
    public func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        let credential = self.keychainManager.getUserCredential()
        
        guard let type = credential.grant_type, let id = credential.client_id, let secret = credential.client_secret else {return}
        
        self.getTokenService.getTokenService(grant_type: type, client_id: id, client_secret: secret)
            .receive(on: DispatchQueue.main)
            .sink { data in
                print(data)
            }
            receiveValue: { [weak self] data in
                guard let data = data, let token = data.tokenData else {return}
                if !String.isNilOrEmpty(string: token) {
                    self?.keychainManager.setToken(token: token)
                    completion(true)
                    }else{
                    completion(false)
                    }
        }
            .store(in: &subscriber)
    }
}
