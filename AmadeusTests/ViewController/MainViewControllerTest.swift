//
//  MainViewControllerTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import XCTest
@testable import Amadeus

final class MainViewControllerTest: XCTestCase, DependencyAssemblerInjector {

    var sut: MainViewController!

    override func setUp() {
        let view = MockMainView()
        let navigationController = UINavigationController(rootViewController: UIViewController())
        sut = MainViewController(viewModel: view.makeMainViewModel(coordinator: MockMainCoordinator(navigationController: navigationController)))
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    

}
