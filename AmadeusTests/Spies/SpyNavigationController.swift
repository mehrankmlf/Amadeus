//
//  SpyNavigationController.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/23/22.
//

import Foundation
@testable import Amadeus
import UIKit

class SpyNavigationController : UINavigationController {
    
    var pushedViewController : UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: false)
    }
}
