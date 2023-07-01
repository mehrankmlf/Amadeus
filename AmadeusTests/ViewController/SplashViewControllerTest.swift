//
//  SplashViewControllerTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 6/27/23.
//

import XCTest
@testable import Amadeus

final class SplashViewControllerTest: XCTestCase {
    
    var sut: SplashViewController!
    
    override func setUp() {
        sut = SplashViewController()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testSplashViewController_WhenCreated_SholdStartTimer() {
        // Arrange
        let expected: TimeInterval = 4
        // Act
        sut.setupTimer()
        
        let durationExpectation = expectation(description: "durationExpectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + expected, execute: {
            // Assert
            durationExpectation.fulfill()
            XCTAssertEqual(4.0, self.sut.timer.duration, "'durationInSeconds' is not set to correct value.")
        })
        waitForExpectations(timeout: expected, handler: nil)
    }
}
