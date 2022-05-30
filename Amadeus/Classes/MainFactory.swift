//
//  MainFactory.swift
//  SappPlus
//
//  Created by Mehran on 1/10/1401 AP.
//

import Foundation

protocol MainFactory {
    func makeMainViewController(coordinator : MainCoordinator) -> MainViewController
    func makeMainViewModel(coordinator : MainCoordinator) -> MainViewModel
}
