//
//  AuthenticationFactory.swift
//  SappPlus
//
//  Created by Mehran on 1/5/1401 AP.
//

import UIKit

protocol LoginViewFactory {
    func makeLoginViewController(coordinator : AuthenticationCoordinator) -> LoginViewController
    func makeLoginViewModel(coordinator : AuthenticationCoordinator) -> LoginViewModel
}

protocol RegisterFactory {
    func makeRegisterViewController(coordinator : AuthenticationCoordinator) -> RegisterViewController
    func makeRegisterViewModel(coordinator : AuthenticationCoordinator) -> RegisterViewModel
}
