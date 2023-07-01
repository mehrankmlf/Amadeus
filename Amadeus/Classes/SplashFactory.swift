//
//  SplashFactory.swift
//  Amadeus
//
//  Created by Mehran on 1/9/1401 AP.
//

import Foundation

protocol SplashFactory {
    func makeSplashViewController(coordinator:  SplashCoordinatorProtocol) -> SplashViewController
}
