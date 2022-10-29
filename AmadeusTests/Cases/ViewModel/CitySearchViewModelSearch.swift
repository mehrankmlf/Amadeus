//
//  CitySearchViewModelSearch.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import XCTest
import Combine
@testable import Amadeus
 
class CitySearchViewModelSearch: XCTestCase {

    private var mockSearch : MockCitySearch!
    private var viewModelToTest : MainViewModel!
    private var subscriber : Set<AnyCancellable> = []

    override func setUp()  {
        mockSearch = MockCitySearch()
        viewModelToTest = MainViewModel(useCase: mockSearch)
    }

    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        mockSearch = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testCityViewModelService_WhenServieCalled_ShouldReturnResponse() {
        
        let result = BaseResponseCitySearch()
        
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &subscriber)
        mockSearch.fetchResult = Result.success(result).publisher.eraseToAnyPublisher()
        viewModelToTest.getCityData(countryCode: "", keyword: "")
        
        wait(for: [expectation], timeout: 1)
    }
}

