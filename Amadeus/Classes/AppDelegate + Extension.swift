//
//  AppDelegate + Extension.swift
//  Amadeus
//
//  Created by Mehran on 8/14/1399 AP.
//  Copyright © 1399 MediumApp. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static var window: UIWindow? {
        return self.appDelegate().window
    }
}
