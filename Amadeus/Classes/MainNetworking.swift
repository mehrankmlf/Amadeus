//
//  MainNetworking.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation

enum MainNetworking {
    
    case hotelSearch(cityCode: String)
}

extension MainNetworking: TargetType {
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v2
    }

    var path: RequestType {
        switch self {
        case .hotelSearch(let code):
            return .queryParametrs(query: "\("/shopping/hotel-offers")\(["cityCode":code].queryString)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .hotelSearch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .hotelSearch:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
