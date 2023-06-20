//
//  BaseAPI + Extension.swift
//  Amadeus
//
//  Created by Mehran on 11/20/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//

import UIKit
import Alamofire

extension BaseAPI  {

    func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    func buildTarget(target: RequestType) -> String {
        switch target {
        case .requestPath(path: let path):
            return path
        case .queryParametrs(query: let query):
            return query
        }
    }
}

