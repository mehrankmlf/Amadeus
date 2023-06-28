//
//  MockNavigationController.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 6/28/23.
//

import UIKit
@testable import Amadeus

final class MockUINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(
        _ viewController: UIViewController, animated: Bool
    ) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
    }
    
    var presentCalled = false
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        super.present(
            viewControllerToPresent, animated: flag, completion: completion
        )
        presentCalled = true
    }
}
