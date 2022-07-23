//
//  MockView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/23/22.
//

import Foundation
@testable import Amadeus

class MockView : LoginViewFactory {
    
    var viewController : LoginViewController!
    var viewModel : LoginViewModel!
    
    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController {
        return viewController
    }
    
    func makeLoginViewModel(coordinator: AuthenticationCoordinator) -> LoginViewModel {
        return viewModel
    }
}
