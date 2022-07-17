//
//  ResponseMock.swift
//  AmadeusTest
//
//  Created by Mehran on 1/12/1401 AP.
//

import Foundation
@testable import Amadeus

extension HotelSearchResponse {
    static let mockData = HotelSearchResponse(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true)
}

extension Hotel_Response {
    static let mockData = Hotel_Response(type: "type", hotelID: "1", name: "testName", address: Address_Response.mockData)
}

extension Address_Response {
    static let mockData = Address_Response(lines: ["address"], postalCode: "021", cityName: "tehran")
}
