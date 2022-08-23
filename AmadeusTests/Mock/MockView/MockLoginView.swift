//
//  MockView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/23/22.
//

import Foundation
@testable import Amadeus

class MockLoginView : LoginViewFactory {
    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController {
        let viewModel = makeLoginViewModel(coordinator: coordinator)
        let initialViewController = LoginViewController(viewModel: viewModel)
        return initialViewController
    }
    
    func makeLoginViewModel(coordinator: AuthenticationCoordinator) -> LoginViewModel {
        let mockLogin = MockLogin()
        let viewModel = LoginViewModel(useCase: mockLogin)
        return viewModel
    }
}
