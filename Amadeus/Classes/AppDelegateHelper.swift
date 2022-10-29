//
//  AppDelegateHelper.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 12/19/21.
//

import UIKit

protocol Command {
    func execute()
}

final class StartCommonBuilder {
    func build() -> [Command] {
        return [ClearKeycahin()]
    }
}

// Clear keychain after new installation
struct ClearKeycahin : Command {
    
    func execute() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")

        if freshInstall {
            // remove all data types related from app
            KeychainStore.eraseAll()
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
}

