//
//  AuthenticationCoordinator.swift
//  Amadeus
//
//  Created by Mehran on 12/29/1400 AP.
//

import UIKit
import Combine

protocol AuthenticationFactory {
    var loginViewFactory : LoginViewFactory { get set }
}

protocol AuthenticationCoordinatorProtocol : Coordinator, AuthenticationFactory {
    func showLoginViewController()
    init(_ navigationController : UINavigationController,
         loginViewFactory : LoginViewFactory)
}

final class AuthenticationCoordinator : AuthenticationCoordinatorProtocol, DependencyAssemblerInjector {

    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .authentication }
    var loginViewFactory : LoginViewFactory
    private var subscriber = Set<AnyCancellable>()
    
    
    init(_ navigationController: UINavigationController,
         loginViewFactory : LoginViewFactory) {
        self.navigationController = navigationController
        self.loginViewFactory = loginViewFactory
    }
    
    func start() {
        showLoginViewController()
    }
}

extension AuthenticationCoordinator {
    func showLoginViewController() {
        let vc = self.dependencyAssembler.makeLoginViewController(coordinator: self)
        vc.navigateSubject.sink { [weak self] event in
            switch event {
            case .login:
                self?.finish()
            }
        }.store(in: &subscriber)
        navigationController.pushViewController(vc, animated: true)
    }
}
