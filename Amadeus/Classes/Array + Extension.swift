//
//  Array + Extension.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 8/16/22.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index]: nil
    }
}
