//
//  SplashNetworking.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 10/11/21.
//

import Foundation
import Alamofire

enum UserTokenNetworking {
    
    case accessToken(grant_type: String, client_id :String, client_secret: String)
}

extension UserTokenNetworking : NetworkTarget {
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v1
    }
    
    var path: String {
        return "/security/oauth2/token"
    }
    
    var methodType: HTTPMethod {
        return .post
    }
    
    var task: Task {
        switch self {
        case .accessToken(grant_type: let grant_type, client_id: let client_id, client_secret: let client_secret):
            return .requestParameters(parameters: ["grant_type":grant_type, "client_id": client_id, "client_secret": client_secret], encoding: URLEncoding.httpBody)
        }
    }
    
    var providerType: AuthProviderType {
        .none
    }
    
    var contentType: ContentType? {
        return .urlFormEncoded
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
}
