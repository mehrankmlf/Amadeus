//
//  AlertFactory.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 4/20/22.
//

import Foundation

protocol AlertAdapter {
    func Loading()
    func dismiss()
    func LoadingWithMessage(message: String)
    func success(message: String)
    func error(message: String)
}
