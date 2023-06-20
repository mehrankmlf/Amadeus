//
//  DetailFactory.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 8/6/22.
//

import Foundation

protocol DetailFactory {
    func makeDetailViewController(coordinator: MainCoordinator) -> DetailViewController
    func makeDetailViewModel(coordinator: MainCoordinator) -> DetailViewModel
}
