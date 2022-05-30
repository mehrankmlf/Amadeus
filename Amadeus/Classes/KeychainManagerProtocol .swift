//
//  KeychainManagerProtocol .swift
//  SappPlus
//
//  Created by Mehran on 2/13/1401 AP.
//

import Foundation
import SwiftKeychainWrapper

protocol KeyChainWrapperProtcol {
    var keyChain : KeychainWrapper { get }
}

protocol TokenManagment : KeyChainWrapperProtcol {
    func signInUser()
    func signOutUser()
    func getToken() -> String?
    func setToken(token :String)
    func setUsetCredential(grant_type: String, client_id: String, client_secret: String)
    func signIn(grant_type: String, client_id: String, client_secret: String, token:String)
    func getUserCredential() -> (grant_type: String?, client_id: String?, client_secret: String?)
}
