//
//  Enums.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 9/12/21.
//

import Foundation

enum ViewModelStatus : Equatable {
    case loadStart
    case dismissAlert
    case emptyStateHandler(title : String, isShow : Bool)
}

enum AppStoryboard: String {
    case splash = "Splash"
    case registration = "Registration"
    case drawer = "Drawer"
    case dashboard = "Dashboard"
    case onBoarding = "OnBoarding"
    case settings = "Settings"
}

enum UserDefaultKeys: String, CaseIterable {
    case userId
    case isAdmin
    case pinCode
}


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

enum EndpointUrlType {
    case base
    case staging
    
    var schema : String {
        switch self {
        case .base: return "http"
        case .staging: return "http"
        }
    }
    
    var host : String {
        switch self {
        case .base: return "api.namadplus.com"
        case .staging: return "api.test.com"
        }
    }
    
    var path : String {
        switch self {
        default: return "/"
        }
    }
}

enum StatusCodeType : Int , Codable {
    case success = 0
    case requestIsNotPermitted = 31
    case failed = 42
    case NotFound = 1
    case ServerError = 2
    case InvalidToken = 3
    case TokenExpired = 4
    case Disabled = 23
    case ValueIsNull = 19
}

enum PermisionType : Int {
    
    case camera = 1
    case contact = 2
    case photoLibrary = 3
    case location = 4
    case photoCamera = 5
    
    var desc: String {
        switch self {
            
        case .camera:
            return "You do not have permission to access the Camera, you can access the application through the device settings, Privacy menu"
        case .contact:
            return "You have not allowed access to Contact, you can access the application through the device settings, under the Privacy menu"
        case .photoLibrary:
            return "You are not allowed to access Photos, you can access the app through the device settings under the Privacy menu"
        case .location:
            return "You are not allowed to access Location, you can access the application through the device settings, under the Privacy menu"
        case .photoCamera:
            return "You are not allowed to access Photo and Camera, you can access the application through the device settings, under the Privacy menu"
        }
    }
}


public enum Model : String {
    
    //Simulator
    case simulator     = "simulator/sandbox",
         
         //iPod
         iPod1              = "iPod 1",
         iPod2              = "iPod 2",
         iPod3              = "iPod 3",
         iPod4              = "iPod 4",
         iPod5              = "iPod 5",
         
         //iPad
         iPad2              = "iPad 2",
         iPad3              = "iPad 3",
         iPad4              = "iPad 4",
         iPadAir            = "iPad Air ",
         iPadAir2           = "iPad Air 2",
         iPadAir3           = "iPad Air 3",
         iPad5              = "iPad 5", //iPad 2017
         iPad6              = "iPad 6", //iPad 2018
         iPad7              = "iPad 7", //iPad 2019
         
         //iPad Mini
         iPadMini           = "iPad Mini",
         iPadMini2          = "iPad Mini 2",
         iPadMini3          = "iPad Mini 3",
         iPadMini4          = "iPad Mini 4",
         iPadMini5          = "iPad Mini 5",
         
         //iPad Pro
         iPadPro9_7         = "iPad Pro 9.7\"",
         iPadPro10_5        = "iPad Pro 10.5\"",
         iPadPro11          = "iPad Pro 11\"",
         iPadPro12_9        = "iPad Pro 12.9\"",
         iPadPro2_12_9      = "iPad Pro 2 12.9\"",
         iPadPro3_12_9      = "iPad Pro 3 12.9\"",
         
         //iPhone
         iPhone4            = "iPhone 4",
         iPhone4S           = "iPhone 4S",
         iPhone5            = "iPhone 5",
         iPhone5S           = "iPhone 5S",
         iPhone5C           = "iPhone 5C",
         iPhone6            = "iPhone 6",
         iPhone6Plus        = "iPhone 6 Plus",
         iPhone6S           = "iPhone 6S",
         iPhone6SPlus       = "iPhone 6S Plus",
         iPhoneSE           = "iPhone SE",
         iPhone7            = "iPhone 7",
         iPhone7Plus        = "iPhone 7 Plus",
         iPhone8            = "iPhone 8",
         iPhone8Plus        = "iPhone 8 Plus",
         iPhoneX            = "iPhone X",
         iPhoneXS           = "iPhone XS",
         iPhoneXSMax        = "iPhone XS Max",
         iPhoneXR           = "iPhone XR",
         iPhone11           = "iPhone 11",
         iPhone11Pro        = "iPhone 11 Pro",
         iPhone11ProMax     = "iPhone 11 Pro Max",
         iPhoneSE2          = "iPhone SE 2nd gen",
         
         //Apple TV
         AppleTV            = "Apple TV",
         AppleTV_4K         = "Apple TV 4K",
         unrecognized       = "?unrecognized?"
}



