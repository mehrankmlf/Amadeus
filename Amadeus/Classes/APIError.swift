//
//  APIError.swift
//  Amadeus
//
//  Created by Mehran on 6/4/1401 AP.
//

import Foundation

enum APIError : Error {
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case invalidResponse(httpStatusCode : Int)
    case statusMessage(message : String)
    case decodingError(Error)
    case connectionError(Error)
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
        case .invalidResponse(let code):  return "Invalid Server Response: \(code)"
        case .statusMessage(let message): return message
        case .decodingError(let error):   return "Decoding Error: \(error.localizedDescription)"
        case .connectionError(let error): return "Network connection Error : \(error.localizedDescription)"
        }
    }
}
