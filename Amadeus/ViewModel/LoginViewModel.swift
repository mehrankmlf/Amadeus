//
//  LoginViewModel.swift
//  Amadeus
//
//  Created by Mehran on 3/10/1401 AP.
//

import Foundation
import SwiftKeychainWrapper
import Combine

protocol BaseLoginViewModel {
    var useCase: GetTokenProtocol { get }
    func getTokenData(grant_type: String, client_id: String, client_secret: String)
}

final class LoginViewModel: BaseViewModel, BaseLoginViewModel, KeyChainManagerInjector {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isGetToken: Bool = false
    
    let usernameMessagePublisher = PassthroughSubject<String, Never>()
    let passwordMessagePublisher = PassthroughSubject<String, Never>()
    let keychainWrapper = KeychainWrapper(serviceName: KeychainWrapper.standard.serviceName,
                                          accessGroup: KeychainWrapper.standard.accessGroup)
    var useCase: GetTokenProtocol
    
    init(useCase: GetTokenProtocol) {
        self.useCase = useCase
    }
}

extension LoginViewModel {
    func getTokenData(grant_type: String, client_id: String, client_secret: String) {
        super.callWithProgress(argument: self.useCase.getTokenService(grant_type: grant_type,
                                                                      client_id: client_id,
                                                                      client_secret: client_secret)) { [weak self] data in
            guard let data = data else {return}
            self?.keychainManager.signIn(grant_type: grant_type,
                                         client_id: client_id,
                                         client_secret: client_secret,
                                         token: data.tokenData)
            self?.isGetToken = true
        }
    }
}

extension LoginViewModel {
    
    var validateUserName: AnyPublisher<String?, Never> {
        
        $userName
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { name in
                guard name.count != 0 else {
                    self.usernameMessagePublisher.send("Username can't be blank")
                    return nil
                }
                guard name.count > 2 else {
                    self.usernameMessagePublisher.send("Minimum of 3 characters required")
                    return nil
                }
                self.usernameMessagePublisher.send("")
                return name
            }.eraseToAnyPublisher()
    }
    
    var validatePassword: AnyPublisher<String?, Never> {
        
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                guard password.count != 0 else {
                    self.passwordMessagePublisher.send("Username can't be blank")
                    return nil
                }
                guard password.count > 2 else {
                    self.passwordMessagePublisher.send("Minimum of 3 characters required")
                    return nil
                }
                return password
            }
            .eraseToAnyPublisher()
    }
    
    var formValidation: AnyPublisher<(String, String)?, Never> {
        
        return Publishers.CombineLatest(validateUserName, validatePassword)
            .map { name, password in
                guard let name = name, let password = password else {
                    return nil
                }
                return (name, password)
            }
            .eraseToAnyPublisher()
    }
}
