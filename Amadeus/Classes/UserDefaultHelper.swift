//
//  UserDefaultHelper.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 11/2/21.
//

import Foundation

public enum UserDefaultType:String {
    case isShowedWalkthrough
    case isInstalledApp
    case tokenExpireDate
    case isSignIn
    case isSignOut
}

final class UserDefaultHelper {
    
    static func save<T>(value:T , key:UserDefaultType){
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func get<T>(for type:T.Type,key:UserDefaultType) -> T? {
        
        if let value = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return value
        }
        
        return nil
    }
}
