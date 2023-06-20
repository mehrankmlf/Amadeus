//
//  MockHotelsSearch.swift
//  AmadeusTest
//
//  Created by Mehran Kamalifard on 4/10/22.
//

import Foundation
import Combine
@testable import Amadeus

class MockHotelsSearch: HotelsSearchProtocol {
    var fetchResult: AnyPublisher<BaseResponse<[HotelSearchResponse]>?, APIError>!
    func HotelsSearchService(cityCode: String) -> AnyPublisher<BaseResponse<[HotelSearchResponse]>?, APIError> {
        return fetchResult
    }
}


