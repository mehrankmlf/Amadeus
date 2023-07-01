//
//  MainFactory.swift
//  Amadeus
//
//  Created by Mehran on 1/10/1401 AP.
//

import Foundation

protocol MainFactory {
    func makeMainViewController(coordinator: MainCoordinatorProtocol) -> MainViewController
    func makeMainViewModel(coordinator: MainCoordinatorProtocol) -> MainViewModel
}
