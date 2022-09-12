//
//  NetworkTarget + Extension.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 9/7/22.
//

import Foundation

extension NetworkTarget {
    var pathAppendedURL: URL {
        var url = baseURL.desc
        url.appendPathComponent(version.desc)
        url.appendPathComponent(path)
        return url
    }
}

extension NetworkTarget {
    func buildURLRequest() -> URLRequest {
        let url = self.pathAppendedURL
        //prepare a url request
        var urlRequest = URLRequest(url: url)
        //set method for request
        urlRequest.httpMethod = self.methodType.name
        //set requestHeaders for request
        urlRequest.allHTTPHeaderFields = self.headers
        //set authorization header for reqeust 
        let result = self.authorizationHandler(type: self.providerType)
        if let token = result.0, let name = result.1 {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: name)
        }
        //set query parameters for request
        if let queryParams = self.queryParams, queryParams.count > 0,
           let queryParamsEncoding = self.queryParamsEncoding {
            self.setQueryTo(urlRequest: &urlRequest,
                            urlEncoding: queryParamsEncoding,
                            queryParams: queryParams)
        }
        //set body for request
        if let requestBody = self.parameters {
            ///Encoding
            if let bodyEncoding = self.bodyEncoding {
                urlRequest.httpBody = self.encodedBody(bodyEncoding: bodyEncoding,
                                                       requestBody: requestBody)
            } else {
                urlRequest.httpBody = self.encodedBody(bodyEncoding: .JSON,
                                                       requestBody: requestBody)
            }
        }
        urlRequest.cachePolicy = self.cachePolicy ?? URLRequest.CachePolicy.useProtocolCachePolicy
        urlRequest.timeoutInterval = self.timeoutInterval ?? 60
        return urlRequest
    }
    
    private func setQueryTo(urlRequest: inout URLRequest,
                            urlEncoding: URLEncoding,
                            queryParams: [String: String]) {
        guard let url = urlRequest.url else {
            return
        }
        var urlComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
        switch urlEncoding {
        case .default:
            urlComponents?.queryItems = [URLQueryItem]()
            for (name, value) in queryParams {
                urlComponents?.queryItems?.append(URLQueryItem.init(name: name, value: value))
            }
            urlRequest.url = urlComponents?.url
        case .percentEncoded:
            urlComponents?.percentEncodedQueryItems = [URLQueryItem]()
            for (name, value) in queryParams {
                let encodedName = name.addingPercentEncoding(withAllowedCharacters: .nkURLQueryAllowed) ?? name
                let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .nkURLQueryAllowed) ?? value
                let queryItem = URLQueryItem.init(name: encodedName, value: encodedValue)
                urlComponents?.percentEncodedQueryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents?.url
            ///Applicable for PUT and POST method.
            ///When queryParamsEncoding is xWWWFormURLEncoded,
            ///All query parameters are sent inside body.
        case .xWWWFormURLEncoded:
            if let queryParamsData = self.queryParams?.urlEncodedQueryParams().data(using: .utf8) {
                urlRequest.httpBody = queryParamsData
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }
    }
    
    private func encodedBody(bodyEncoding: BodyEncoding,
                             requestBody: [String: Any]) -> Data? {
        switch bodyEncoding {
        case .JSON:
            do {
                return try JSONSerialization.data(withJSONObject: requestBody)
            } catch {
                return nil
            }
        case .xWWWFormURLEncoded:
            do {
                return try requestBody.urlEncodedBody()
            } catch {
                return nil
            }
        }
    }
    
    private func authorizationHandler(type : AuthProviderType) -> (String?, String?) {
        var headerField: String { "Authorization" }
        switch type {
        case .bearer(token: let token):
            return (token, headerField)
        case .none:
            break
        }
        return (nil, nil)
    }
    
    private func getToken() -> String? {
        let 
    }
}
