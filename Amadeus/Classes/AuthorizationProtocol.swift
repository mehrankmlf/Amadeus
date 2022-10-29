//
//  AuthorizationProtocol.swift
//  Amadeus
//
//  Created by Mehran on 7/7/1401 AP.
//

import Foundation
import Combine

protocol AuthorizationRequestProtocol : AnyObject, AccessTokenInjector {
    /// Build the authorization request.
    ///
    /// - parameter request: The request to be sent.
    /// - parameter completion: A callback to invoke when the request completed.
    func authenticateRequest(Completion: @escaping(Bool) -> Void)
}
