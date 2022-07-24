//
//  AuthenticationCoordinatorTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/23/22.
//

import XCTest
@testable import Amadeus

class AuthenticationCoordinatorTest: XCTestCase {

    var sut : AuthenticationCoordinator!
    var navigation : SpyNavigationController!
    
    override func setUp() {
        super.setUp()
        navigation = SpyNavigationController()
        sut = AuthenticationCoordinator(navigation, loginViewFactory: MockLoginView())
    }
    
    override func tearDown() {
        sut = nil
        navigation = nil
        super.tearDown()
    }
    
    func testAuthCoordinator_WhenStartCalled_SetCoordinatorType() {
        let type = sut.type
        XCTAssertEqual(type, .authentication)
    }
    
    func testAuthCoordinator_WhenStartCalled_SetPushedViewController() {
        sut.start()
        guard navigation.pushedViewController is LoginViewController else {
            XCTFail()
            return
        }
    }
    
    func testAuthCoordinator_WhenLoginViewControllerCalled_SetPushedViewController() {
        sut.showLoginViewController()
        guard navigation.pushedViewController is LoginViewController else {
            XCTFail()
            return
        }
    }
}
