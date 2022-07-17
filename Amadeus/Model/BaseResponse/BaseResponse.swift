//
//  BaseResponse.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/14/22.
//

import Foundation

class BaseResponse<T: Decodable>: Decodable {

    var data: T?

    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
