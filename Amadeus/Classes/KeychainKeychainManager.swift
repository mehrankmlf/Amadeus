//
//  KeychainManager.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/11/22.
//

import Foundation
import SwiftKeychainWrapper

enum KeychainKeyType : String  {
    
    case grant_type
    case client_id
    case client_secret
    
    case passKey
    case token
}

extension KeychainKeyType {
    
    var key : String {
        
        switch self  {
        case .grant_type: return "com.grant_type"
        case .client_id: return "com.client_id"
        case .client_secret: return "com.client_secret"
        case .passKey : return "com.passKey"
        case .token : return "com.token"
        }
    }
}

/// Protocol approach replacement for Singelton
protocol KeyChainManagerInjector {
    var keychainManager : KeychainManager { get }
}

fileprivate let sharedAppKeychainManager : KeychainManager = KeychainManager()

extension KeyChainManagerInjector {
    var keychainManager : KeychainManager {
        return sharedAppKeychainManager
    }
}

 class KeychainManager {
     init() {}
}

extension KeychainManager : TokenManagment {
    
    var keyChain: KeychainWrapper {
        return KeychainWrapper(serviceName: KeychainWrapper.standard.serviceName, accessGroup: KeychainWrapper.standard.accessGroup)
    }
    
   func setUsetCredential(grant_type: String, client_id: String, client_secret: String) {
        self.keyChain.set(grant_type, forKey: KeychainKeyType.grant_type.key)
        self.keyChain.set(client_id, forKey: KeychainKeyType.client_id.key)
        self.keyChain.set(client_secret, forKey: KeychainKeyType.client_secret.key)
    }
    
    func getUserCredential() -> (grant_type: String?, client_id: String?, client_secret: String?) {
        
       let granty_type = self.keyChain.string(forKey: KeychainKeyType.grant_type.key)
       let client_id = self.keyChain.string(forKey: KeychainKeyType.client_id.key)
       let client_secret = self.keyChain.string(forKey: KeychainKeyType.client_secret.key)
        
        return (granty_type, client_id, client_secret)
    }
    
    func setToken(token: String) {
        self.removeToken(key: KeychainKeyType.token.key)
        self.keyChain.set(token, forKey: KeychainKeyType.token.key)
    }
    
    func removeToken(key: String) {
        self.keyChain.removeObject(forKey: key)
    }
 
    func getToken() -> String? {
        return self.keyChain.string(forKey: KeychainKeyType.token.key)
    }
    
    func signOutUser() {
        UserDefaultManager.save(value: false, key: .isShowedWalkthrough)
    }
    
    func signInUser() {
        UserDefaultManager.save(value: true, key: .isSignIn)
    }
    
    func signIn(grant_type: String, client_id: String, client_secret: String, token :String) {
        self.setUsetCredential(grant_type: grant_type, client_id: client_id, client_secret: client_secret)
        self.setToken(token: token)
        self.signInUser()
    }
}
