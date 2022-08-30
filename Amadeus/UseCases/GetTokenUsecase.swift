//
//  RegisterDevice_Request.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 10/11/21.
//

import Foundation
import Combine

protocol GetTokenProtocol : AnyObject {
    func getTokenService(grant_type: String, client_id: String, client_secret: String) -> AnyPublisher<GetToken_Response?, APIError>
}

final class GetToken_Request : BaseAPI, GetTokenProtocol {
    func getTokenService(grant_type: String, client_id: String, client_secret: String) -> AnyPublisher <GetToken_Response?, APIError> {
        self.request(with: UserTokenNetworking.accessToken(grant_type: grant_type, client_id: client_id, client_secret: client_secret),
                     scheduler: WorkScheduler.mainScheduler,
                     response: GetToken_Response?.self)
    }
}
