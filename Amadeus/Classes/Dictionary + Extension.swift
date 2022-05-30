//
//  Dictionary + Extension.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 12/5/21.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = ""
        forEach({ output += "\($0.key)=\($0.value)&" })
        output = String(output.dropLast())
        return "?" + output
    }
}
