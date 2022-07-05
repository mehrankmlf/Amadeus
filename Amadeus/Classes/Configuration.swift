//
//  Configuration.swift
//  Amadeus
//
//  Created by Mehran on 3/30/1401 AP.
//

import Foundation

enum BaseURLType {
    case baseApi
    case staging
    
    var desc : String {
        
        switch self {
        case .baseApi :
            return "https://test.api.amadeus.com"
        case .staging :
            return "http://staging.com"
        }
    }
}

enum VersionType {
    case none
    case v1, v2
    
    var desc : String {
        switch self {
        case .none :
            return ""
        case .v1 :
            return "/v1"
        case .v2 :
            return "/v2"
        }
    }
}

enum APIError : Error {
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case statusMessage(message : String)
    case decodeError(String)
}

extension APIError {
    ///Description of error
    var desc: String {
        
        switch self {
        case .general:                    return MessageHelper.serverError.general
        case .timeout:                    return MessageHelper.serverError.timeOut
        case .pageNotFound:               return MessageHelper.serverError.notFound
        case .noData:                     return MessageHelper.serverError.notFound
        case .noNetwork:                  return MessageHelper.serverError.noInternet
        case .unknownError:               return MessageHelper.serverError.general
        case .serverError:                return MessageHelper.serverError.serverError
        case .statusMessage(let message): return message
        case .decodeError(let error):     return error
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
