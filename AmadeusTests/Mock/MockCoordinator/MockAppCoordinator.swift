//
//  MockAppCoordinator.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import UIKit
@testable import Amadeus

final class MockAppCoordinator: AppCoordinatorProtocol {
    
    var finishDelegate: Amadeus.FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Amadeus.Coordinator] = []
    var type: Amadeus.CoordinatorType = .walkthrough
    
    var walkthroughFlowCalled: Bool = false
    
    init(naviagtionController: UINavigationController) {
        self.navigationController = naviagtionController
    }
    
    func showMainFlow() {
        print("")
    }
    
    func showAuthFlow() {
        print("")
    }
    
    func showSplashFlow() {
        
    }
    
    func showWalkthroughFlow() {
        self.walkthroughFlowCalled = true
    }
    
    func isShowWalktroughFlow() {
        print("")
    }
    
    func start() {
        self.showSplashFlow()
    }
}
