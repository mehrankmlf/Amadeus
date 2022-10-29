//
//  MockHotelsSearch.swift
//  AmadeusTest
//
//  Created by Mehran Kamalifard on 4/10/22.
//

import Foundation
import Combine
@testable import Amadeus

class MockCitySearch : CitySearchProtocol {
    var fetchResult : AnyPublisher<BaseResponse<[CitySearchResponse]>?, APIError>!
    func citySearchService(countryCode: String, keyword: String) -> AnyPublisher<BaseResponse<[CitySearchResponse]>?, APIError> {
        return fetchResult
    }
}


