//
//  AuthorizationType.swift
//  Amadeus
//
//  Created by Mehran on 7/7/1401 AP.
//

import Foundation

public enum AuthorizationType: Hashable {
    case none
    case bearer
}

extension AuthorizationType : AccessTokenInjector {
    
    private struct StringValue {
        static let bearer = "Bearer "
    }
    
    public typealias RawValue = String
    
    var rawValue : RawValue {
        switch self {
        case .none:
            return ""
        case .bearer:
            guard let token = self.manager.getToken() else {return ""}
            return "\(StringValue.bearer)\("token")"
        }
    }
}
