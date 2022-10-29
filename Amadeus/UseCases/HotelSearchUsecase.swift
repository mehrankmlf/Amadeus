//
//  CitySearchProtocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation
import Combine

protocol CitySearchProtocol : AnyObject {
    func citySearchService(countryCode: String, keyword: String) -> AnyPublisher <BaseResponse<[CitySearchResponse]>?, APIError>
}

final class CitySearch_Request : NetworkClientManager<MainNetworking>, CitySearchProtocol {
    func citySearchService(countryCode: String, keyword: String) -> AnyPublisher <BaseResponse<[CitySearchResponse]>?, APIError> {
        self.request(with: .citySearch(countryCode: countryCode, keyword: keyword),
                     scheduler: WorkScheduler.mainScheduler,
                     responseObject: BaseResponse<[CitySearchResponse]>?.self)
    }
}
