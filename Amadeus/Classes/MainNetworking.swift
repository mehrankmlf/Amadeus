//
//  MainNetworking.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation

enum MainNetworking {
    
    case hotelSearch(cityCode: String)
}

extension MainNetworking : TargetType {
    
    var baseURL: String {
        return AppBuildConfig.setAppState.baseURL
    }
    
    var version: String {
        return AppBuildConfig.setAppState.version
    }
    
    var path: RequestType {
        switch self {
        case .hotelSearch(let code):
            return .queryParametrs(query: "\("/shopping/hotel-offers")\(["cityCode":code].queryString)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .hotelSearch :
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .hotelSearch:
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
