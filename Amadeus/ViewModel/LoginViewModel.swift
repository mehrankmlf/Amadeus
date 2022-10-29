//
//  LoginViewModel.swift
//  Amadeus
//
//  Created by Mehran on 3/10/1401 AP.
//

import Foundation
import Combine

protocol BaseLoginViewModel {
    var useCase : GetTokenProtocol { get }
    func getTokenData(grant_type: String, client_id: String, client_secret: String)
}

final class LoginViewModel : BaseViewModel, BaseLoginViewModel, AccessTokenInjector {
    
    @Published var userName : String = ""
    @Published var password : String = ""
    @Published var isGetToken : Bool = false
    
    let usernameMessagePublisher = PassthroughSubject<String, Never>()
    let passwordMessagePublisher = PassthroughSubject<String, Never>()

    var useCase: GetTokenProtocol
    
    init(useCase : GetTokenProtocol) {
        self.useCase = useCase
    }
}

extension LoginViewModel {
    func getTokenData(grant_type: String, client_id: String, client_secret: String) {
        super.callWithProgress(argument: self.useCase.getTokenService(grant_type: grant_type, client_id: client_id, client_secret: client_secret)) { [weak self] data in
            guard let data = data else {return}
            print(data)
            self?.manager.signIn(grant_type: grant_type,
                                 client_id: client_id,
                                 client_secret: client_secret,
                                 token: data.tokenData,
                                 expire_date: data.expire_date)
            self?.isGetToken = true
        }
    }
}

extension LoginViewModel {
    
    var validateUserName : AnyPublisher<String?, Never> {
        
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
    
    var validatePassword : AnyPublisher<String?, Never> {
        
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { pass in
                guard pass.count != 0 else {
                    self.passwordMessagePublisher.send("Username can't be blank")
                    return nil
                }
                
                guard pass.count > 2 else {
                    self.passwordMessagePublisher.send("Minimum of 3 characters required")
                    return nil
                }
                return pass
            }
            .eraseToAnyPublisher()
    }
    
    var formValidation: AnyPublisher<(String, String)?, Never> {
        
        return Publishers.CombineLatest(validateUserName, validatePassword)
            .map { name, pass in
                guard let name = name, let pass = pass else {
                    return nil
                }
                return (name, pass)
            }
            .eraseToAnyPublisher()
    }
}
