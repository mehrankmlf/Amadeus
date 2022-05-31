//
//  ResponseMock.swift
//  SappPlusTests
//
//  Created by Mehran on 1/12/1401 AP.
//

import Foundation
@testable import Amadeus

extension DatumLinks {
    static let mockDatumLinks = DatumLinks(flightDates: "flightDates", flightOffers: "flightOffers")
}

extension Price {
    static let mockPrice = Price(total: "price")
}

extension Currencies {
    static let mockCurrencies = Currencies(usd: "usd")
}

extension Location {
    static let mockLocations = Location(subType: "sybType", detailedName: "detailedName")
}

extension Dictionaries {
    static let mockDictionaries = Dictionaries(currencies: Currencies.mockCurrencies)
}

extension Meta {
    static let mockMeta = Meta(currency: "currency", links: nil, defaults: nil)
}

extension DataResponse {
    static let mockDataResponse = DataResponse(type: "", origin: "origin", destination: "destination", departureDate: "departureDate", returnDate: "returnDate", price: Price.mockPrice, links: DatumLinks.mockDatumLinks)
}
