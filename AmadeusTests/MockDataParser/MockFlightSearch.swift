//
//  MockFlightSearch.swift
//  SappPlusTests
//
//  Created by Mehran Kamalifard on 4/10/22.
//

import Foundation
import Combine
@testable import Amadeus

class MockFlightSearch : HotelsSearchProtocol {
    var fetchFlightrResult : AnyPublisher<FlightSearchResponse?, APIError>!
    func flightSearchService(origin: String) -> AnyPublisher<FlightSearchResponse?, APIError> {
        return fetchFlightrResult
    }
}


