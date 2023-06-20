//
//  Address_Response.swift
//  Amadeus
//
//  Created by Mehran on 4/3/1401 AP.
//

import Foundation

struct Address_Response: Decodable {
    let lines: [String]?
    let postalCode: String?
    let cityName: String?
}

extension Address_Response {
    enum CodingKeys: String, CodingKey {
        case lines = "lines"
        case postalCode = "postalCode"
        case cityName = "cityName"
    }
}
