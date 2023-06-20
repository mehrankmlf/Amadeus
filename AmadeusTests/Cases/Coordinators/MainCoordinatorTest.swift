//
//  MainCoordinatorTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/24/22.
//

import XCTest
@testable import Amadeus

class MainCoordinatorTest: XCTestCase {
    
    var sut: MainCoordinator!
    var navigation: SpyNavigationController!
    
    override func setUp() {
        super.setUp()
//        navigation = SpyNavigationController()
//        sut = MainCoordinator(navigation, mainFactory: <#T##MainFactory#>)
    }
    
    override func tearDown() {
        sut = nil
        navigation = nil
        super.tearDown()
    }

}
