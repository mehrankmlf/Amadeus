//
//  WalkthroughCoordinator.swift
//  SappPlus
//
//  Created by Mehran on 12/27/1400 AP.
//

import UIKit
import Combine

protocol WalkthroughCoordinatorProtocol : Coordinator {
    func showWWalkthroughViewController()
}

final class WalkthroughCoordinator : WalkthroughCoordinatorProtocol {
    
    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .walkthrough }
    private var bag = Set<AnyCancellable>()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWWalkthroughViewController()
    }
    
    func showWWalkthroughViewController() {
        let vc = Storyboard.walkthrough.instantiate(WalkthroughViewController.self)
        vc.navigateSubject.sink { _ in
            UserDefaultHelper.save(value: true, key: .isShowedWalkthrough)
            self.finish()
        }.store(in: &bag)
        navigationController.pushViewController(vc, animated: true)
    }
}
