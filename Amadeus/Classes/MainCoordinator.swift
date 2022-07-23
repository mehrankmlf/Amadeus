//
//  MainCoordinator.swift
//  Amadeus
//
//  Created by Mehran on 12/29/1400 AP.
//

import UIKit
import Combine

protocol MainViewFactory {
    var mainFactory : MainFactory { get set }
}

protocol MainCoordinatorProtocol : Coordinator, MainViewFactory {
    func showMainViewController()
    func showDetailViewController(data : HotelSearchResponse)
    init(_ navigationController: UINavigationController, mainFactory : MainFactory)
}

final class MainCoordinator : MainCoordinatorProtocol {

    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    var mainFactory: MainFactory
    private var subscriber = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController, mainFactory : MainFactory) {
        self.navigationController = navigationController
        self.mainFactory = mainFactory
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
        let vc = DetailViewController(data: data, contentView: DetailView())
        navigationController.pushViewController(vc, animated: true)
    }
}

