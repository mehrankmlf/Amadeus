//
//  SplashNavigationTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import XCTest
@testable import Amadeus

final class SplashNavigationTest: XCTestCase {
    
    private var sut: SplashViewController!
    private var splashCoordinator: MockSplashCoordinator!

    override func setUp() {
        sut = SplashViewController()
        let navigationController = UINavigationController(rootViewController: UIViewController())
        splashCoordinator = MockSplashCoordinator(navigationController: navigationController)
        navigationController.pushViewController(sut, animated: false)
    }
    
    override func tearDown() {
        sut = nil
        splashCoordinator = nil
    }
    
    func test_SplashViewController_whenPushCalled_thenPushOnNavigationCalled() {
        sut.navigateSubject.send(.splash)
        splashCoordinator.start()
        
        XCTAssertTrue(splashCoordinator.vcCalled)
     }
    
    func test_WalkthroughViewController_whenInitiated_shouldReturnWalkthroghEnum() {
        XCTAssertEqual(splashCoordinator.type, .splash)
    }
}
