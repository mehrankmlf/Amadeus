//
//  URL + Extension.swift
//  Amadeus
//
//  Created by Mehran on 6/4/1401 AP.
//

import Foundation

extension URL {
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
}
