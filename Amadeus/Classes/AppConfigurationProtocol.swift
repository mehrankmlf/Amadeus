//
//  Protocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 9/12/21.
//

import Foundation
import Combine

//MARK: - Protocols

// App Configuration Base
protocol AppConfiguration {
    
    var baseURL: BaseURLType { get }
    
    var version: VersionType { get }
    
    func isVPNConnected() -> Bool
    func isJailBrokenDevice() -> Bool
    func enableCertificatePinning() -> Bool
    func displayVersion() -> String
}

// App Configuration Set Base
protocol AppConfigurable {
    static var setAppState: AppConfiguration { get }
}




