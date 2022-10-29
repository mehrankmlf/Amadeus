//
//  RequestNewToken.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/2/22.
//

import Foundation
import Combine

protocol RequestNewTokenProtocol  {
//    func refreshToken() -> Future<Bool, Error>
}

final class RequestNewToken : RequestNewTokenProtocol {
    
    private var subscriber = Set<AnyCancellable>()
    private let queue = DispatchQueue(label: "RequestNewToken")
//    
//    public func refreshToken() -> Future<Bool, Error> {
//
//        let credential = self.keychainManager.getUserCredential()
//
//        return Future { [weak self] promise in
//            
//            guard let type = credential.grant_type, let id = credential.client_id, let secret = credential.client_secret else {return}
//
//            let requestEnv : UserTokenNetworking = .accessToken(grant_type: type, client_id: id, client_secret: secret)
//            let request = requestEnv.buildURLRequest()
//            queue.sync {
//                return request.dataTaskPublisher
//                    .retry(3)
//                    .sink { _ in}
//            receiveValue: { [weak self] data in
//                do {
//                    //                        let decoder = JSONDecoder()
//                    //                        let data = try decoder.decode(GetToken_Response.self, from: data.data)
//                    guard let decodedResponse: GetToken_Response = self?.decode(data.data) else {return}
//                    self?.keychainManager.setToken(token: decodedResponse.tokenData)
//                    promise(.success(true))
//                } catch  {
//                    promise(.failure(error))
//                }
//            }
//            .store(in: &subscriber)
//            }
//        }
//    }
    
    func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            print(error)
            return nil
        }
    }
}
