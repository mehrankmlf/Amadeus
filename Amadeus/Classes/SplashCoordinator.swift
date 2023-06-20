//
//  SplashCoordinator.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 3/16/22.
//

import Combine
import UIKit

protocol SplashFactorty {
    var splashFactory: SplashFactory { get set }
}

protocol SplashCoordinatorProtocol: Coordinator, SplashFactorty {
    func showSplashViewController()
    init(_ navigationController: UINavigationController, splashFactory: SplashFactory)
}

final class SplashCoordinator: SplashCoordinatorProtocol, DependencyAssemblerInjector {
    
    weak var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .splash }
    var splashFactory: SplashFactory
    private var subscriber = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController, splashFactory: SplashFactory) {
        self.navigationController = navigationController
        self.splashFactory = splashFactory
   }
    
    func start() {
        self.showSplashViewController()
    }

    func showSplashViewController() {
        let vc = self.dependencyAssembler.makeSplashViewController(coordinator: self)
        vc.navigateSubject.sink { event in
            switch event {
            case .splash:
                self.finish()
            }
        }.store(in: &subscriber)
        navigationController.pushViewController(vc, animated: true)
    }
}

