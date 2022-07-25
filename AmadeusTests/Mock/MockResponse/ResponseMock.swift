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

//let hotelSearchResponseMockData : BaseResponse<[HotelSearchResponse]> = [
//    .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
//    .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: false),
//    .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
//    .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
//]

class BaseResponseHotelSearch : BaseResponse<[HotelSearchResponse]> {
    override init() {
        super.init()
        self.data = [
           .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
           .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: false),
            .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
           .init(type: HotelType.hotelOffers, hotel: Hotel_Response.mockData, available: true),
        ]
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

