//
//  TargetType.swift
//  NetworkLayer
//
//  Created by Mehran on 5/21/20.
//  Copyright © 2020 Mehran. All rights reserved.
//

import Foundation
import Alamofire

enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

//This defines the parameters to pass along with the request
enum RequestParams {
    case body(_: [String: Any]?)
    case url(_: [String: Any]?)
}

protocol NetworkTarget {
    var baseURL: BaseURLType { get }
    var version : VersionType { get }
    var path: String { get }
    var methodType: HTTPMethod { get }
    var parameters:  [String: String] { get }
    var task: Task { get }
    var providerType: AuthProviderType { get }
    var contentType: ContentType? { get }
    var headers: [String: String]? { get }
}
 extension NetworkTarget {
    var pathAppendedURL: URL {
        var url = baseURL.desc
        url.appendPathComponent(version.desc)
        url.appendPathComponent(path)
        return url
    }
}
