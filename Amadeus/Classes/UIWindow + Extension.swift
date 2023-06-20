//
//  UIWindow + Extension.swift
//  Amadeus
//
//  Created by Mehran on 8/14/1399 AP.
//  Copyright © 1399 MediumApp. All rights reserved.
//

import UIKit

extension UIWindow {
    
    static var currentWindow: UIWindow?  {
        var window: UIWindow?
        if let windowInner = AppDelegate.window {
            window = windowInner
        }else if let windowInner = UIApplication.shared.keyWindow {
            window = windowInner
        }
        return window
    }
}
