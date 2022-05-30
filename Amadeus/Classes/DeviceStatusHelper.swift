//
//  DeviceStatusHelper.swift
//  mediumapp
//
//  Created by Mehran on 7/17/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//

import UIKit

final class DeviceStatusHelper {
    
    static func getDeviceUniqueID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? MessageHelper.DeviceStatus.unknownDeviceID
    }
    
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    static func getAppNumericVersion() -> String {
        
        let strVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        return strVersion.replacingOccurrences(of: ".", with: "")
    }
    
    static func getAppBuildNumber() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }

    static func getBundleIdentifier() -> String {
        return Bundle.main.bundleIdentifier!
    }

}
