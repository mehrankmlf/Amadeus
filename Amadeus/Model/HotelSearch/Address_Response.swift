//
//  Address_Response.swift
//  Amadeus
//
//  Created by Mehran on 4/3/1401 AP.
//

import Foundation

struct Address_Response : Decodable {
    var countryCode: String?
    var stateCode : String?
}

extension Address_Response {
    enum CodingKeys: String, CodingKey {
        case countryCode = "countryCode"
        case stateCode = "stateCode"
    }
}
