//
//  NavigationTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import XCTest
@testable import Amadeus

final class WalkthroughNavigationTest: XCTestCase {

    private var sut: WalkthroughViewController!
    private var walkthroughCoordinator: MockWalkthroughCoordinator!
    
    override func setUp() {
        sut = WalkthroughViewController()
        let navigationController = UINavigationController(rootViewController: UIViewController())
        walkthroughCoordinator = MockWalkthroughCoordinator(naviagtionController: navigationController)
        navigationController.pushViewController(sut, animated: false)
    }
    
    override func tearDown() {
        sut = nil
        walkthroughCoordinator = nil
    }
    
    func test_WalkthroughViewController_whenPushCalled_thenPushOnNavigationCalled() {
        sut.navigateSubject.send(.walkthrough)
        walkthroughCoordinator.start()
        
        XCTAssertTrue(walkthroughCoordinator.vcCalled)
     }
    
    func test_WalkthroughViewController_whenInitiated_shouldReturnWalkthroghEnum() {
        XCTAssertEqual(walkthroughCoordinator.type, .walkthrough)
    }
}
