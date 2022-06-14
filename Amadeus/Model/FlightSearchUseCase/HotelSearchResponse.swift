//
//  HotelSearchResponse.swift
//  Amadeus
//
//  Created by Mehran on 3/24/1401 AP.
//

import Foundation

struct HotelSearchResponse: Codable {
    let chainCode: String?
    let iataCode: IataCode?
    let dupeID: Int?
    let name, hotelID: String?

    enum CodingKeys: String, CodingKey {
        case chainCode = "chainCode"
        case iataCode = "iataCode"
        case dupeID = "dupeId"
        case name = "name"
        case hotelID = "hotelId"
    }
}

enum IataCode: String, Codable {
    case paris = "PAR"
}
