//
//  MainNetworking.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation

enum MainNetworking {
    
    case citySearch(countryCode: String, keyword : String)
}

extension MainNetworking : NetworkTarget {

    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v1
    }
    
    var path: String {
        return "/reference-data/locations/cities"
    }
    
    var methodType: HTTPMethod {
        .get
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .citySearch(let country, let key) :
            return ["countryCode":country, "keyword":key]
        }
    }
    
    var queryParamsEncoding: URLEncoding? {
        return .default
    }

    var authorization: AuthorizationType {
        return .bearer
    }
}
