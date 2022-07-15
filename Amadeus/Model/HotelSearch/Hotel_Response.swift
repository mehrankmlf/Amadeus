//
//  Hotel_Response.swift
//  Amadeus
//
//  Created by Mehran on 4/3/1401 AP.
//

import Foundation

struct Hotel_Response : Decodable {
    let type: String?
    let hotelID : String?
    let name: String?
    let address: Address_Response?
}

extension Hotel_Response {
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case hotelID = "hotelId"
        case name = "name"
        case address = "address"
    }
}
