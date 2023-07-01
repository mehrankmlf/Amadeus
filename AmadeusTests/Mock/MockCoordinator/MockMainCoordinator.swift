//
//  MockMainCoordinator.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import UIKit
@testable import Amadeus

final class MockMainCoordinator: MainCoordinatorProtocol {
    
    var finishDelegate: Amadeus.FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Amadeus.Coordinator] = []
    var type: Amadeus.CoordinatorType = .authentication
    var loginViewFactory: Amadeus.LoginViewFactory = MockLoginView()
    
    var mainFactory: Amadeus.MainFactory = MockMainView()
    var detailFactory: Amadeus.DetailFactory = MockDetaiLView()
    
    var vcCalled = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainViewController()
    }
    
    func showMainViewController() {
        vcCalled = true
    }
}
