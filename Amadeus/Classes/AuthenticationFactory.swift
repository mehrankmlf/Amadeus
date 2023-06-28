//
//  AuthenticationFactory.swift
//  Amadeus
//
//  Created by Mehran on 1/5/1401 AP.
//

import UIKit

protocol LoginViewFactory {
    func makeLoginViewController(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewController
    func makeLoginViewModel(coordinator: AuthenticationCoordinatorProtocol) -> LoginViewModel
}

