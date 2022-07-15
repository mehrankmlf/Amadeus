//
//  AppDelegateHelper.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 12/19/21.
//

import SwiftKeychainWrapper
import UIKit

protocol Command {
    func execute()
}

final class StartCommonBuilder {
    func build() -> [Command] {
        return [ClearKeycahin()]
    }
}

// clear keychain data after  new installation
struct ClearKeycahin : Command {
    
    func execute() {
        let keyChain = KeychainWrapper(serviceName: KeychainWrapper.standard.serviceName)
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")

        if freshInstall {
            let _ : Bool = keyChain.removeObject(forKey: KeychainKeyType.passKey.key)
            let _ : Bool = keyChain.removeObject(forKey: KeychainKeyType.token.key)
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
}

