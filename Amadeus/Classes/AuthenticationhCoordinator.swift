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
    var registerViewFactory : RegisterFactory { get set }
}

protocol AuthenticationCoordinatorProtocol : Coordinator, AuthenticationFactory {
    func showLoginViewController()
    func showRegisterViewController()
    init(_ navigationController : UINavigationController,
         loginViewFactory : LoginViewFactory,
         registerViewFactory : RegisterFactory)
}

final class AuthenticationCoordinator : AuthenticationCoordinatorProtocol, DependencyAssemblerInjector {

    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .authentication }
    var loginViewFactory : LoginViewFactory
    var registerViewFactory: RegisterFactory
    private var bag = Set<AnyCancellable>()
    
    
    init(_ navigationController: UINavigationController,
         loginViewFactory : LoginViewFactory,
         registerViewFactory : RegisterFactory) {
        self.navigationController = navigationController
        self.loginViewFactory = loginViewFactory
        self.registerViewFactory = registerViewFactory
    }
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let vc = self.dependencyAssembler.makeLoginViewController(coordinator: self)
        vc.navigateSubject.sink { [weak self] event in
            switch event {
            case .login:
                self?.finish()
            case .register:
                self?.showRegisterViewController()
            }
        }.store(in: &bag)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showRegisterViewController() {
        let vc = self.registerViewFactory.makeRegisterViewController(coordinator: self)
        vc.navigationSubject.sink { [weak self] event in
            switch event {
            case .register:
                self?.finish()
            case .onBack:
                self?.navigationController.popViewController(animated: true)
            }
        }.store(in: &bag)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
}
