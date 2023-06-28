//
//  MockAuthenticateCoordinator.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 6/28/23.
//

import UIKit
@testable import Amadeus

final class MockAuthenticateCoordinator: AuthenticationCoordinatorProtocol {

    var finishDelegate: Amadeus.FinishDelegate?
    var navigationController: UINavigationController = MockUINavigationControllerMock()
    var childCoordinators: [Amadeus.Coordinator] = []
    var type: Amadeus.CoordinatorType = .authentication
    var loginViewFactory: Amadeus.LoginViewFactory = MockLoginView()
    var vcCalles = false
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
          vcCalles = true
    }
}


