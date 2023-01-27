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

final class CitySearch_Request : NetworkClientManager<HttpRequest>, CitySearchProtocol {
    func citySearchService(countryCode: String, keyword: String) -> AnyPublisher <BaseResponse<[CitySearchResponse]>?, APIError> {
        self.request(request: HttpRequest(request: CitySearchRequest(code: countryCode, key: keyword)),
                     scheduler: WorkScheduler.mainScheduler,
                     responseObject: BaseResponse<[CitySearchResponse]>?.self)
    }
}
