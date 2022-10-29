//
//  KeychainManagerProtocol .swift
//  Amadeus
//
//  Created by Mehran on 2/13/1401 AP.
//

import Foundation

protocol AccessTokenStoreProtocol {
    func signInUser()
    func signOutUser()
    func getToken() -> String?
    func setToken(token :String)
    func setExpire_Data(date: Int)
    func getExire_Date() -> Int?
    func setUsetCredential(grant_type: String, client_id: String, client_secret: String)
    func signIn(grant_type: String, client_id: String, client_secret: String, token:String, expire_date: Int)
    func getUserCredential() -> (grant_type: String?, client_id: String?, client_secret: String?)
}
