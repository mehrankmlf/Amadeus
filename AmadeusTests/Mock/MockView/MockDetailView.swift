//
//  MockDetaiLView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import Foundation
@testable import Amadeus

final class MockDetaiLView: DetailFactory {
    func makeDetailViewController(coordinator: MainCoordinator) -> DetailViewController {
        let viewMdoel = makeDetailViewModel(coordinator: coordinator)
        return DetailViewController(viewModel: viewMdoel)
    }
    
    func makeDetailViewModel(coordinator: MainCoordinator) -> DetailViewModel {
        return DetailViewModel()
    }
}
