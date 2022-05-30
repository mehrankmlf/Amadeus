//
//  SplashNetworking.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 10/11/21.
//

import Foundation
import Alamofire

enum UserTokenNetworking {
    
    case accessToken(grant_type: String, client_id :String, client_secret: String)
}

extension UserTokenNetworking : TargetType {
    
    var baseURL: String {
        return BuildConfig.setAppState.baseURL
    }
    
    var version: String {
        return BuildConfig.setAppState.version
    }
    
    var path: RequestType {
        switch self {
        case .accessToken:
            return .requestPath(path: "/security/oauth2/token")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .accessToken :
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .accessToken(let grantType, let clientId, let clientSecret):
            return .requestParameters(parameters: ["grant_type":grantType, "client_id": clientId, "client_secret": clientSecret], encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String : String]? {
        switch self {
        default :
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
}
