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

extension MainNetworking : NetworkTarget {
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v2
    }
    
    var path: String {
        return "/shopping/hotel-offers"
    }
    
    var methodType: HTTPMethod {
        .get
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .hotelSearch(let code) :
            return ["cityCode":code]
        }
    }
    
    var queryParamsEncoding: URLEncoding? {
        return .default
    }
    
    var bodyEncoding: BodyEncoding? {
        return .xWWWFormURLEncoded
    }

    var headers: [String : String]? {
        return nil
    }
    
    var providerType: AuthProviderType {
        return .bearer(token: "")
    }
}
