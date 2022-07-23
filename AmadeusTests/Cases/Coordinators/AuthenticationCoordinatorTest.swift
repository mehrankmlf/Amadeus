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
        sut = AuthenticationCoordinator(navigation, loginViewFactory: <#LoginViewFactory#>)
    }
    
    override func tearDown() {
        sut = nil
        navigation = nil
        super.tearDown()
    }
}
