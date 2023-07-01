//
//  DependencyAssembler.swift
//  Amadeus
//
//  Created by Mehran on 1/5/1401 AP.
//

import Foundation


fileprivate let sharedDependencyAssembler: AppDependencyAssembler = AppDependencyAssembler()

protocol DependencyAssemblerInjector {
    var dependencyAssembler: AppDependencyAssembler { get }
}

extension DependencyAssemblerInjector {
    var dependencyAssembler: AppDependencyAssembler {
        return sharedDependencyAssembler
    }
}

final class AppDependencyAssembler {
     init() {}
}

extension AppDependencyAssembler: LoginViewFactory {
    func makeLoginViewController(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewController {
        let vc = LoginViewController(viewModel: self.makeLoginViewModel(coordinator: coordinator))
        return vc
    }
    
    func makeLoginViewModel(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewModel {
        let viewModel = LoginViewModel(useCase:  GetToken_Request())
        return viewModel
    }
}

extension AppDependencyAssembler: SplashFactory {
    func makeSplashViewController(coordinator: SplashCoordinatorProtocol) -> SplashViewController {
        let vc = SplashViewController()
        return vc
    }
}

extension AppDependencyAssembler: MainFactory {
    func makeMainViewController(coordinator: MainCoordinatorProtocol) -> MainViewController {
        let vc = MainViewController(viewModel: self.makeMainViewModel(coordinator: coordinator))
        return vc
    }
    
    func makeMainViewModel(coordinator: MainCoordinatorProtocol) -> MainViewModel {
        let viewModel = MainViewModel(useCase: HotelSearch_Request())
        return viewModel
    }
}

extension AppDependencyAssembler: DetailFactory {
    func makeDetailViewController(coordinator: MainCoordinator) -> DetailViewController {
        let vc = DetailViewController(viewModel: self.makeDetailViewModel(coordinator: coordinator))
        return vc
    }
    
    func makeDetailViewModel(coordinator: MainCoordinator) -> DetailViewModel {
        let viewModel = DetailViewModel()
        return viewModel
    }
}
