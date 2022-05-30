//
//  MainNetworking.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation

enum MainNetworking {
    
    case flightSearch(origin: String)
}

extension MainNetworking : TargetType {
    
    var baseURL: String {
        return BuildConfig.setAppState.baseURL
    }
    
    var version: String {
        return BuildConfig.setAppState.version
    }
    
    var path: RequestType {
        switch self {
        case .flightSearch(let origin):
            return .queryParametrs(query: "\("/shopping/flight-destinations")\(["origin":origin].queryString)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .flightSearch :
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .flightSearch:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        default :
            return nil
        }
    }
}
