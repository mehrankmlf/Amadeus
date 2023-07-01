//
//  MockSplashView.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/1/23.
//

import Foundation
@testable import Amadeus

final class MockSplashView: SplashFactory {
    func makeSplashViewController(coordinator: SplashCoordinatorProtocol) -> SplashViewController {
        return SplashViewController()
    }
}
