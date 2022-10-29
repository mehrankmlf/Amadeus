//
//  CitySearchResponse.swift
//  Amadeus
//
//  Created by Mehran on 3/24/1401 AP.
//

import Foundation

struct CitySearchResponse: Decodable {
    var type : String?
    var subType: String?
    var name: String?
    var iataCode: String?
    var address: Address_Response?
}

extension CitySearchResponse {
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case subType = "subType"
        case name = "name"
        case iataCode = "iataCode"
        case address = "address"
    }
}
