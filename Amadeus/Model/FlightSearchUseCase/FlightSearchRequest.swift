//
//  FlightSearchRequest.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/13/22.
//

import Foundation
import Combine

protocol FlightSearchProtocol : AnyObject {
    func flightSearchService(origin :String) -> AnyPublisher <FlightSearchResponse?, APIError>
}

class FlightSearch_Request : BaseAPI<MainNetworking>, FlightSearchProtocol {
    
    func flightSearchService(origin : String) -> AnyPublisher <FlightSearchResponse?, APIError> {
        
        self.fetchData(target: .flightSearch(origin: origin), responseClass: FlightSearchResponse.self)
    }
}
