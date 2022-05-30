//
//  KeychainkeyChain.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/11/22.
//

import Foundation
import SwiftKeychainWrapper


/// a protocol base replacement for Singelton
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
       let client_secret = self.keyChain.string(forKey: KeychainKeyType.client_id.key)
        
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
        UserDefaultHelper.save(value: false, key: .isShowedWalkthrough)
    }
    
    func signInUser() {
        UserDefaultHelper.save(value: true, key: .isSignIn)
    }
    
    func signIn(grant_type: String, client_id: String, client_secret: String, token :String) {
        self.setUsetCredential(grant_type: grant_type, client_id: client_id, client_secret: client_secret)
        self.setToken(token: token)
        self.signInUser()
    }
}