//
//  MockSplashCoordinator.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import UIKit
@testable import Amadeus

final class MockSplashCoordinator: SplashCoordinatorProtocol {
    
    var finishDelegate: Amadeus.FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Amadeus.Coordinator] = []
    var type: Amadeus.CoordinatorType = .splash
    var splashFactory: Amadeus.SplashFactory = MockSplashView()
    var vcCalled = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showSplashViewController()
    }
    
    func showSplashViewController() {
        self.vcCalled = true
    }
    
}
