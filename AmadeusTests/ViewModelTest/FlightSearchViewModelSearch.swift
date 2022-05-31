//
//  FlightSearchViewModelSearch.swift
//  SappPlusTests
//
//  Created by Mehran Kamalifard on 4/10/22.
//

import XCTest
import Combine
@testable import Amadeus

class FlightSearchViewModelSearch: XCTestCase {
    
    private var mockFlightSearch : MockFlightSearch!
    private var viewModelToTest : MainViewModel!
    private var bag : Set<AnyCancellable> = []


    override func setUpWithError() throws {
        mockFlightSearch = MockFlightSearch()
        viewModelToTest = MainViewModel(getFlightInspiration: mockFlightSearch)
    }

    override func tearDownWithError() throws {
        mockFlightSearch = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }
    
    func testFlightData() {
        let data = DataResponse.mockDataResponse
        let dictionaries = Dictionaries(currencies: Currencies.mockCurrencies)
        let flightToSearch = FlightSearchResponse(data: [data], dictionaries: dictionaries, meta: Meta.mockMeta)
        let expectation = XCTestExpectation(description: "State is set to Token")

        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &bag)

        mockFlightSearch.fetchFlightrResult = Result.success(flightToSearch).publisher.eraseToAnyPublisher()
        viewModelToTest.getFlightInspirationData(origin: "")

        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFlightDataIsNil() {
        let flightToSearch = FlightSearchResponse(data: nil, dictionaries: nil, meta: nil)
        let expectation = XCTestExpectation(description: "State is set to Token")

        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &bag)

        mockFlightSearch.fetchFlightrResult = Result.success(flightToSearch).publisher.eraseToAnyPublisher()
        viewModelToTest.getFlightInspirationData(origin: "")

        wait(for: [expectation], timeout: 1)
    }
}
