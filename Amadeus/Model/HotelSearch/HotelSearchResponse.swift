//
//  HotelSearchResponse.swift
//  Amadeus
//
//  Created by Mehran on 3/24/1401 AP.
//

import Foundation

struct HotelSearchResponse: Decodable {
    var type: HotelType?
    var hotel: Hotel_Response?
    var available: Bool?
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

extension HotelSearchResponse {
    func availableText() -> String {
        guard let available = self.available else {return ""}
        return available ? "Available": "Not Available"
    }
}
