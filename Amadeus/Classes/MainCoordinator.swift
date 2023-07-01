//
//  MainCoordinator.swift
//  Amadeus
//
//  Created by Mehran on 12/29/1400 AP.
//

import UIKit
import Combine

protocol MainViewFactory {
    var mainFactory: MainFactory { get set }
    var detailFactory: DetailFactory { get set }
}

protocol MainCoordinatorProtocol: Coordinator, MainViewFactory {
    func showMainViewController()
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    var mainFactory: MainFactory
    var detailFactory: DetailFactory
    private var subscriber = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController,
         mainFactory: MainFactory,
         detailFactory: DetailFactory) {
        self.navigationController = navigationController
        self.mainFactory = mainFactory
        self.detailFactory = detailFactory
    }
    
    func start() {
        showMainViewController()
    }
    
    func showMainViewController() {
        let vc = self.mainFactory.makeMainViewController(coordinator: self)
        vc.navigateSubject.sink { [weak self] event in
            switch event {
            case .main:
                self?.finish()
            case .detail(data: let data):
                self?.showDetailViewController(data: data)
            }
        }.store(in: &subscriber)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailViewController(data: HotelSearchResponse) {
        let vc = self.detailFactory.makeDetailViewController(coordinator: self)
        vc.data = data
        navigationController.pushViewController(vc, animated: true)
    }
}

