//
//  AuthNavigationTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import XCTest
@testable import Amadeus

final class AuthNavigationTest: XCTestCase {
    
    private var sut: LoginViewController!
    private var authenticateCoordinator: MockAuthenticateCoordinator!

    override func setUp() {
        let mockLogin = MockLoginView()
        let navigationController = UINavigationController(rootViewController: UIViewController())
        authenticateCoordinator = MockAuthenticateCoordinator(navigationController: navigationController)
        sut = LoginViewController(viewModel:  mockLogin.makeLoginViewModel(coordinator: authenticateCoordinator))
        navigationController.pushViewController(sut, animated: false)
    }
    
    override func tearDown() {
        sut = nil
        authenticateCoordinator = nil
    }
    
    func test_SplashViewController_whenPushCalled_thenPushOnNavigationCalled() {
        sut.navigateSubject.send(.login)
        authenticateCoordinator.start()
        
        XCTAssertTrue(authenticateCoordinator.vcCalled)
     }
    
    func test_WalkthroughViewController_whenInitiated_shouldReturnWalkthroghEnum() {
        XCTAssertEqual(authenticateCoordinator.type, .authentication)
    }
}
