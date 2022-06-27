//
//  ResponseMock.swift
//  SappPlusTests
//
//  Created by Mehran on 1/12/1401 AP.
//

import Foundation
@testable import Amadeus

//extension DatumLinks {
//    static let mockDatumLinks = DatumLinks(flightDates: "flightDates", flightOffers: "flightOffers")
//}
//
//extension Price {
//    static let mockPrice = Price(total: "price")
//}
//
//extension Currencies {
//    static let mockCurrencies = Currencies(usd: "usd")
//}
//
//extension Location {
//    static let mockLocations = Location(subType: "sybType", detailedName: "detailedName")
//}
//
//extension Dictionaries {
//    static let mockDictionaries = Dictionaries(currencies: Currencies.mockCurrencies)
//}
//
//extension Meta {
//    static let mockMeta = Meta(currency: "currency", links: nil, defaults: nil)
//}

extension HotelSearchResponse {
    static let mockData = HotelSearchResponse(type: "HotelType", hotel: Hotel_Response.mockData, available: true)
}

extension Hotel_Response {
    static let mockData = Hotel_Response(type: "type", hotelID: "1", name: "testName", address: Address_Response.mockData)
}

extension Address_Response {
    static let mockData = Address_Response(lines: ["address"], postalCode: "021", cityName: "tehran")
}
