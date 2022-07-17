//
//  CoordinatorProtocol.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 3/6/22.
//

import UIKit
import Combine

protocol Coordinator : AnyObject {
    var finishDelegate : FinishDelegate? { get set }
    var navigationController : UINavigationController { get set }
    var childCoordinators : [Coordinator] { get set }
    var type : CoordinatorType { get }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordonator: self)
    }
}

protocol FinishDelegate : AnyObject {
    func coordinatorDidFinish(childCoordonator : Coordinator)
}

enum CoordinatorType {
    case walkthrough
    case splash
    case authentication
    case main
}
