//
//  RequestNewToken.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/2/22.
//

import Foundation
import Alamofire

final class RequestNewToken : KeyChainManagerInjector {
    
    var interceptor : RequestInterceptorHelper!
    var getTokenService: GetTokenProtocol!
    
    init(interceptor : RequestInterceptorHelper,
         getTokenService : GetTokenProtocol) {
        self.interceptor = interceptor
        self.getTokenService = getTokenService
    }
    
    public func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        guard !interceptor.isRetrying else { return }
        
        interceptor.isRetrying = true
        
        let credential = self.keychainManager.getUserCredential()
        
        guard let type = credential.grant_type, let id = credential.client_id, let secret = credential.client_secret else {return}
        
        //        let targetUrl = "https://test.api.amadeus.com/v1/security/oauth2/token"
        //        let parameters = ["grant_type": credential.grant_type, "client_id": credential.client_id, "client_secret": credential.client_secret]
        //        let header : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        //        AF.request(targetUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
        //
        //            if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
        //                                                      as? [String: Any])?["access_token"] as? String {
        //                self.keychainManager.setToken(token: token)
        //                print("\nRefresh token completed successfully. New token is: \(token)\n")
        //                completion(true)
        //            } else {
        //                completion(false)
        //            }
        //        }
        self.getTokenService.getTokenService(grant_type: type, client_id: id, client_secret: secret)
            .sink { <#Subscribers.Completion<APIError>#> in
            } receiveValue: { [weak self] data in
                guard let data = data?.access_token else {return}
                
            }
    }
}
