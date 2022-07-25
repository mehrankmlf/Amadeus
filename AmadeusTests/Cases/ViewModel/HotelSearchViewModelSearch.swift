//
//  HotelSearchViewModelSearch.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import XCTest
import Combine
@testable import Amadeus

class HotelSearchViewModelSearch: XCTestCase {

    private var mockSearch : MockHotelsSearch!
    private var viewModelToTest : MainViewModel!
    private var subscriber : Set<AnyCancellable> = []

    override func setUp()  {
        mockSearch = MockHotelsSearch()
        viewModelToTest = MainViewModel(getHotels: mockSearch)
    }

    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        mockSearch = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testHotelsViewModelService_WhenServieCalled_ShouldReturnResponse() {
        
        let result = BaseResponseHotelSearch()
        
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &subscriber)
        mockSearch.fetchResult = Result.success(result).publisher.eraseToAnyPublisher()
        viewModelToTest.getHotelsData(cityCode: "")
        
        wait(for: [expectation], timeout: 1)
    }
}

//class TestClass : BaseResponse<[HotelSearchResponse]> {
//    override init() {
//        super.init()
//        self.data = hotelSearchResponseMockData
//    }
//
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
//}
