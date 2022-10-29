//
//  AccessTokenStore.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/11/22.
//

import Foundation

enum KeychainKeyType : String  {
    
    case grant_type
    case client_id
    case client_secret
    
    case passKey
    case token
    case expire_data
}

extension KeychainKeyType {
    
    var key : String {
        
        switch self  {
        case .grant_type: return "com.grant_type"
        case .client_id: return "com.client_id"
        case .client_secret: return "com.client_secret"
        case .passKey : return "com.passKey"
        case .token : return "com.token"
        case .expire_data : return "com.expire"
        }
    }
}

/// Protocol approach replacement for Singelton
protocol AccessTokenInjector {
    var manager : AccessTokenStore { get }
}

fileprivate let sharedAppKeychainManager : AccessTokenStore = AccessTokenStore()

extension AccessTokenInjector {
    var manager : AccessTokenStore {
        return sharedAppKeychainManager
    }
}

struct AccessTokenStore : AccessTokenStoreProtocol {

    func setUsetCredential(grant_type: String, client_id: String, client_secret: String) {
        KeychainStore.save(value: grant_type, key: KeychainKeyType.grant_type.key)
        KeychainStore.save(value: client_id, key: KeychainKeyType.client_id.key)
        KeychainStore.save(value: client_secret, key: KeychainKeyType.client_secret.key)
    }
    
    func getUserCredential() -> (grant_type: String?, client_id: String?, client_secret: String?) {
        let granty_type = KeychainStore.get(forKey: KeychainKeyType.grant_type.key, asType: String.self)
        let client_id = KeychainStore.get(forKey: KeychainKeyType.client_id.key, asType: String.self)
        let client_secret = KeychainStore.get(forKey: KeychainKeyType.client_secret.key, asType: String.self)
        
        return (granty_type, client_id, client_secret)
    }
    
    func setToken(token: String) {
        self.removeElements(key: KeychainKeyType.token.key)
        KeychainStore.save(value: token, key: KeychainKeyType.token.key)
    }
    
    func getToken() -> String? {
        return KeychainStore.get(forKey: KeychainKeyType.token.key, asType: String.self)
    }
    
    func setExpire_Data(date: Int) {
        self.removeElements(key: KeychainKeyType.expire_data.key)
        KeychainStore.save(value: date, key: KeychainKeyType.expire_data.key)
    }
    
    func getExire_Date() -> Int? {
        return KeychainStore.get(forKey: KeychainKeyType.expire_data.key, asType: Int.self)
    }
    
    func signOutUser() {
        UserDefaultManager.save(value: false, key: .isShowedWalkthrough)
    }
    
    func signInUser() {
        UserDefaultManager.save(value: true, key: .isSignIn)
    }
    
    private func removeElements(key: String) {
        KeychainStore.erase(key: key)
    }
    
    func signIn(grant_type: String, client_id: String, client_secret: String, token :String, expire_date: Int) {
        self.setUsetCredential(grant_type: grant_type, client_id: client_id, client_secret: client_secret)
        self.setToken(token: token)
        self.setExpire_Data(date: expire_date)
        self.signInUser()
    }
}

