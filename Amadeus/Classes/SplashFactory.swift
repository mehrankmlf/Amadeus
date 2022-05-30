//
//  SplashFactory.swift
//  SappPlus
//
//  Created by Mehran on 1/9/1401 AP.
//

import Foundation

protocol SplashFactory {
    func makeSplashViewController(coordinator :  SplashCoordinator) -> SplashViewController
    func makeSplashViewModel(coordinator : SplashCoordinator) -> SplashViewModel
}