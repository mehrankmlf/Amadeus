//
//  LoginViewControllerTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 6/27/23.
//

import XCTest
@testable import Amadeus

final class LoginViewControllerTest: XCTestCase, DependencyAssemblerInjector {
    
    var sut: LoginViewController!

    override func setUp() {
        sut = LoginViewController(viewModel: self.dependencyAssembler.makeLoginViewModel(coordinator: MockAuthenticateCoordinator()))
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testLoginViewController() {
        
        let view = sut.contentView
        
        XCTAssertEqual(view.txtID.text, "")
        XCTAssertEqual(view.txtSecret.text, "")
    }
}
