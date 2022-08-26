//
//  BaseAPIDebuger.swift
//  Amadeus
//
//  Created by Mehran on 6/4/1401 AP.
//

import Foundation

struct BaseAPIDebuger {
    func log(request: URLRequest, error : Error?) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
       \(urlAsString) \n\n
       \(method) \(path)?\(query) HTTP/1.1 \n
       HOST: \(host)\n
       """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
        guard let err = error else {
            output += "  STATUS: SUCCESS \n"
          print(output)
          return
        }
        output += "STATUS: FAILED \n"
        output += "ERROR: \(err.localizedDescription)\n"
        print(output)
    }
}
