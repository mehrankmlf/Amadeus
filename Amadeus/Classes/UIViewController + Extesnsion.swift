//
//  UIViewController + Extesnsion.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 10/12/21.
//

import UIKit

public extension UIViewController {

    /// The storyboard identifier for the controller
    static var storyboardIdentifier: String {
        self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
