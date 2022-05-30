//
//  RequestInterCeptorProtocol.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 5/8/22.
//

import Foundation

protocol RequestInterceptorProtocol {
    var retryLimit : Int { get }
    var isRetrying : Bool { get }
    var retryDelay : TimeInterval { get }
}

