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
        self.fetchData(target: .hotelSearch(cityCode: cityCode), responseClass: BaseResponse<[HotelSearchResponse]>.self)
    }
}
