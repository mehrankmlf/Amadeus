//
//  ResponseMock.swift
//  AmadeusTest
//
//  Created by Mehran on 1/12/1401 AP.
//

import Foundation
@testable import Amadeus

extension CitySearchResponse {
    static let mockData = CitySearchResponse(type: CityType.hotelOffers, hotel: Address_Response.mockData, available: true)
}

extension Address_Response {
    static let mockData = Address_Response(type: "type", hotelID: "1", name: "testName", address: Address_Response.mockData)
}

extension Address_Response {
    static let mockData = Address_Response(lines: ["address"], postalCode: "021", cityName: "tehran")
}

class BaseResponseCitySearch : BaseResponse<[CitySearchResponse]> {
    override init() {
        super.init()
        self.data = [
           .init(type: HotelType.hotelOffers, hotel: Address_Response.mockData, available: true),
           .init(type: HotelType.hotelOffers, hotel: Address_Response.mockData, available: false),
            .init(type: HotelType.hotelOffers, hotel: Address_Response.mockData, available: true),
           .init(type: HotelType.hotelOffers, hotel: Address_Response.mockData, available: true),
        ]
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

