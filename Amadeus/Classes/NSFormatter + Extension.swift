//
//  NSFormatter + Extension.swift
//  Amadeus
//
//  Created by Mehran on 1/4/1401 AP.
//

import Foundation

extension DateFormatter {
    
     static let shortDateAndTime:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
     static let dayMonthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
     static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMyyyy")
        return formatter
    }()
}
