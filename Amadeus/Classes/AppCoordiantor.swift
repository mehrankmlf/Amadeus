//
//  AppCoordiantor.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 3/16/22.
//

import UIKit

protocol AppCoordinatorProtocol : Coordinator {
    func showMainFlow()
    func showAuthFlow()
    func showSplashFlow()
    func showWalkthroughFlow()
    func isShowWalktroughFlow()
}

class AppCoordinator : AppCoordinatorProtocol, DependencyAssemblerInjector, KeyChainManagerInjector {
     
    weak var finishDelegate : FinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type : CoordinatorType { .splash }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showSplashFlow()
    }
        
    func showSplashFlow() {
        let splash = SplashCoordinator.init(navigationController, splashFactory: self.dependencyAssembler)
        splash.finishDelegate = self
        splash.start()
        childCoordinators.append(splash)
    }
    
    func showWalkthroughFlow() {
        let walktrough = WalkthroughCoordinator.init(navigationController)
        walktrough.finishDelegate = self
        walktrough.start()
        childCoordinators.append(walktrough)
    }
    
    func showAuthFlow() {
        if isSignin() {
            self.showMainFlow()
        }else{
            let login = AuthenticationCoordinator.init(navigationController, loginViewFactory: self.dependencyAssembler)
            login.finishDelegate = self
            login.start()
            childCoordinators.append(login)
        }
    }
    
    func isShowWalktroughFlow() {
        isShowWalktrough() ? showAuthFlow() : showWalkthroughFlow()
    }
    
    func showMainFlow() {
        let main = MainCoordinator.init(navigationController,
                                        mainFactory: self.dependencyAssembler,
                                        detailFactory: self.dependencyAssembler)
        main.finishDelegate = self
        main.start()
        childCoordinators.append(main)
    }
}

extension AppCoordinator : FinishDelegate {
    
    func coordinatorDidFinish(childCoordonator: Coordinator) {
        
        childCoordinators = childCoordinators.filter({ $0.type != childCoordonator.type })
        
        switch childCoordonator.type {
        case .walkthrough:
            navigationController.viewControllers.removeAll()
            showAuthFlow()
        case .splash:
            navigationController.viewControllers.removeAll()
            isShowWalktroughFlow()
        case .authentication:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        case .main:
            navigationController.viewControllers.removeAll()
            // show next flow whenever mainflow finished
        }
    }
}

extension AppCoordinator {
    func isShowWalktrough() -> Bool {
        return UserDefaultManager.get(for: Bool.self, key: .isShowedWalkthrough) ?? false
    }
}

extension AppCoordinator {
    func isSignin() -> Bool {
        return UserDefaultManager.get(for: Bool.self, key: .isSignIn) ?? false
    }
}
