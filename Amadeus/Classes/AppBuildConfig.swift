//
//  BuildConfig.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 6/28/21.
//  Copyright © 2021 MediumApp. All rights reserved.
//

import Foundation

struct AppBuildConfig : AppConfigurable {
    
    static var setAppState: AppConfiguration {
        // return help you to change thec AppConfigState
        return Realese()
    }
}

private struct Realese : AppConfiguration {
    
    var baseURL : BaseURLType = .baseApi
    
    var version : VersionType = .none
    
    func isVPNConnected() -> Bool {
        return false
    }
    
    func isJailBrokenDevice() -> Bool {
        return false
    }
    
    func enableCertificatePinning() -> Bool {
        return false
    }
    
    func displayVersion() -> String {
        return DeviceStatusHelper.getAppVersion()
    }
}

private struct PenTest : AppConfiguration {
    
    var baseURL : BaseURLType = .baseApi
    
    var version : VersionType = .none
    
    func isVPNConnected() -> Bool {
        return false
    }
    
    func isJailBrokenDevice() -> Bool {
        return false
    }
    
    func enableCertificatePinning() -> Bool {
        return false
    }
    
    func displayVersion() -> String {
        return DeviceStatusHelper.getAppVersion()
    }
}

