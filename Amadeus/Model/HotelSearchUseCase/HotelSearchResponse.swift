//
//  HotelSearchResponse.swift
//  Amadeus
//
//  Created by Mehran on 3/24/1401 AP.
//

import Foundation

struct HotelSearchResponse: Decodable {
    let type : HotelType?
    let hotel: Hotel_Response?
    let available: Bool?
//    let offers: String?
}

extension HotelSearchResponse {
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case hotel = "hotel"
        case available = "available"
    }
}

enum HotelType: String, Codable {
    case hotelOffers = "hotel-offers"
}
