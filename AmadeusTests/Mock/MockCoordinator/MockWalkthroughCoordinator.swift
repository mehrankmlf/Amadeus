//
//  MockWalkthroughCoordinator.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import UIKit
@testable import Amadeus

final class MockWalkthroughCoordinator: WalkthroughCoordinatorProtocol {
    
    var finishDelegate: Amadeus.FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Amadeus.Coordinator] = []
    var type: Amadeus.CoordinatorType = .walkthrough
    var vcCalled = false
    
    init(naviagtionController: UINavigationController) {
        self.navigationController = naviagtionController
    }
    
    func start() {
        self.showWWalkthroughViewController()
    }
    
    func showWWalkthroughViewController() {
        vcCalled = true
    }
}
