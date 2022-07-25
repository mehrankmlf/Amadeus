//
//  LoginViewModel.swift
//  Amadeus
//
//  Created by Mehran on 3/10/1401 AP.
//

import Foundation
import SwiftKeychainWrapper
import Combine

typealias BaseLoginViewModel = ViewModelBaseProtocol & LogiViewModel

protocol LogiViewModel {
    var useCase : GetTokenProtocol { get }
    func getTokenData(grant_type: String, client_id: String, client_secret: String)
}

final class LoginViewModel : BaseViewModel, BaseLoginViewModel, KeyChainManagerInjector {
    var loadinState: CurrentValueSubject<ViewModelStatus, Never>
    
    @Published var userName : String = ""
    @Published var password : String = ""
    @Published var isGetToken : Bool = false
    
    let usernameMessagePublisher = PassthroughSubject<String, Never>()
    let passwordMessagePublisher = PassthroughSubject<String, Never>()
    
    let keychainWrapper = KeychainWrapper(serviceName: KeychainWrapper.standard.serviceName,
                                          accessGroup: KeychainWrapper.standard.accessGroup)
    var useCase: GetTokenProtocol
    
    init(useCase : GetTokenProtocol) {
        self.useCase = useCase
    }
    
    func getTokenData(grant_type: String, client_id: String, client_secret: String) {
        
        super.callWithProgress(argument: self.useCase.getTokenService(grant_type: grant_type, client_id: client_id, client_secret: client_secret)) { [weak self] data in
            guard let data = data else {return}
            self?.keychainManager.signIn(grant_type: grant_type, client_id: client_id, client_secret: client_secret, token: data.tokenData)
            self?.isGetToken = true
        }
        
        //        self.useCase.getTokenService(grant_type: grant_type, client_id: client_id, client_secret: client_secret)
        //            .sink { <#Subscribers.Completion<APIError>#> in
        //                copletionHandler .T
        //            } receiveValue: { <#GetToken_Response?#> in
        //                <#code#>
        //            }
        
        //        self.loadinState.send(.loadStart)
        //
        //        self.useCase.getTokenService(grant_type: grant_type, client_id: client_id, client_secret: client_secret)
        //            .subscribe(on: Scheduler.backgroundWorkScheduler)
        //            .receive(on: Scheduler.mainScheduler)
        //            .sink { [weak self] result in
        //                switch result {
        //                case .finished:
        //                    self?.loadinState.send(.dismissAlert)
        //                case .failure(let error):
        //                    self?.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
        //                }
        //            } receiveValue: { [weak self] data in
        //                self?.loadinState.send(.dismissAlert)
        //                guard let data = data else {return}
        //                self?.keychainManager.signIn(grant_type: grant_type, client_id: client_id, client_secret: client_secret, token: data.tokenData)
        //                self?.isGetToken = true
        //            }
        //            .store(in: &subscriber)
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
