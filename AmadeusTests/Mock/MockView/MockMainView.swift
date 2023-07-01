//
//  MockMainView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import Foundation
@testable import Amadeus

final class MockMainView: MainFactory {
    func makeMainViewController(coordinator: MainCoordinatorProtocol) -> Amadeus.MainViewController {
        let viewModel = makeMainViewModel(coordinator: coordinator)
        return MainViewController(viewModel: viewModel)
    }
    
    func makeMainViewModel(coordinator: MainCoordinatorProtocol) -> Amadeus.MainViewModel {
        let mockHotelSearch = MockHotelsSearch()
        return MainViewModel(useCase: mockHotelSearch)
    }
}
