//
//  MockLogin.swift
//  AmadeusTest
//
//  Created by Mehran on 1/12/1401 AP.
//

import Foundation
import Combine
@testable import Amadeus

class MockLogin :  GetTokenProtocol {
    var fetchedTokenResult : AnyPublisher<GetToken_Response?, APIError>!
    func getTokenService(grant_type: String, client_id: String, client_secret: String) -> AnyPublisher<GetToken_Response?, APIError> {
        return fetchedTokenResult
    }
}
