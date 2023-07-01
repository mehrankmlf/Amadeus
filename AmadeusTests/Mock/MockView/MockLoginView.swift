//
//  MockView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/23/22.
//

import Foundation
@testable import Amadeus

final class MockLoginView: LoginViewFactory {
    func makeLoginViewController(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewController {
        let viewModel = makeLoginViewModel(coordinator: coordinator)
        return LoginViewController(viewModel: viewModel)
    }

    func makeLoginViewModel(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewModel {
        let mockLogin = MockLogin()
        return LoginViewModel(useCase: mockLogin)
    }
}
