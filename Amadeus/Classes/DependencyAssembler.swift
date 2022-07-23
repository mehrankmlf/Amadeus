//
//  DependencyAssembler.swift
//  Amadeus
//
//  Created by Mehran on 1/5/1401 AP.
//

import Foundation


fileprivate let sharedDependencyAssembler : DependencyAssembler = DependencyAssembler()

protocol DependencyAssemblerInjector {
    var dependencyAssembler : DependencyAssembler { get }
}

extension DependencyAssemblerInjector {
    var dependencyAssembler : DependencyAssembler{
        return sharedDependencyAssembler
    }
}

final class DependencyAssembler {
     init() {}
}

extension DependencyAssembler : LoginViewFactory {
    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController {
        let vc = LoginViewController(viewModel: self.makeLoginViewModel(coordinator: coordinator), contentView: LoginView())
        vc.viewModel = self.makeLoginViewModel(coordinator: coordinator)
        return vc
    }
    
    func makeLoginViewModel(coordinator: AuthenticationCoordinator) -> LoginViewModel {
        let viewModel = LoginViewModel(getTokenService:  GetToken_Request())
        return viewModel
    }
}

extension DependencyAssembler : SplashFactory {
    func makeSplashViewController(coordinator: SplashCoordinator) -> SplashViewController {
        let vc = SplashViewController(viewModel: self.makeSplashViewModel(coordinator: coordinator), contentView: SplashView())
        return vc
    }
    
    func makeSplashViewModel(coordinator: SplashCoordinator) -> SplashViewModel {
        let viewModel = SplashViewModel()
        return viewModel
    }
}

extension DependencyAssembler : MainFactory {
    func makeMainViewController(coordinator: MainCoordinator) -> MainViewController {
        let vc = MainViewController(viewModel: self.makeMainViewModel(coordinator: coordinator), contentView: MainView())
        vc.viewModel = self.makeMainViewModel(coordinator: coordinator)
        return vc
    }
    
    func makeMainViewModel(coordinator: MainCoordinator) -> MainViewModel {
        let viewModel = MainViewModel(getHotels: HotelSearch_Request())
        return viewModel
    }
}
