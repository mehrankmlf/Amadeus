//
//  HotelsSearchProtocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation
import Combine

protocol HotelsSearchProtocol : AnyObject {
    func HotelsSearchService(cityCode :String) -> AnyPublisher <BaseResponse<[HotelSearchResponse]>?, APIError>
}

final class HotelSearch_Request : BaseAPI<MainNetworking>, HotelsSearchProtocol {
    func HotelsSearchService(cityCode : String) -> AnyPublisher <BaseResponse<[HotelSearchResponse]>?, APIError> {
        self.request(with: .hotelSearch(cityCode: cityCode),
                     scheduler: WorkScheduler.mainScheduler,
                     response: BaseResponse<[HotelSearchResponse]>?.self)
    }
}
