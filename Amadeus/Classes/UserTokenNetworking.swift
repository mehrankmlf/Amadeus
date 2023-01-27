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
    
    var path: String? {
        return "/security/oauth2/token"
    }
    
    var methodType: HTTPMethod {
        return .post
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .accessToken(grant_type: let grant_type, client_id: let client_id, client_secret: let client_secret):
            return ["grant_type":grant_type, "client_id": client_id, "client_secret": client_secret]
        }
    }
    
    var queryParamsEncoding: URLEncoding? {
        return .xWWWFormURLEncoded
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
}

struct UserTokenRequest : NetworkTarget {
    
    let grant_Type : String
    let client_id : String
    let client_secret : String
    
    init(grant_type: String, client_id :String, client_secret: String) {
        self.grant_Type = grant_type
        self.client_id = client_id
        self.client_secret = client_secret
    }
    
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v1
    }
    
    var path: String? {
        return "/security/oauth2/token"
    }
    
    var methodType: HTTPMethod {
        return .post
    }
    
    var queryParams: [String : String]? {
        return ["grant_type":grant_Type, "client_id": client_id, "client_secret": client_secret]
    }
    
    var queryParamsEncoding: URLEncoding? {
        return .xWWWFormURLEncoded
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
}
