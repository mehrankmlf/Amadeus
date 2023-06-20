//
//  MessageHelper.swift
//  Amadeus
//
//  Created by Mehran on 7/17/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//

import Foundation

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general: String = "Bad Request"
        static let noInternet: String = "Check the Connection"
        static let timeOut: String = "Timeout"
        static let notFound: String = "No Result"
        static let serverError: String = "Internal Server Error"
    }
    
    struct DeviceStatus {
        static let unknownDeviceID: String = "Device ID Not Found"
    }
}

