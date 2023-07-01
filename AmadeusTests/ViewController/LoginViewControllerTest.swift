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
        let navigationController = UINavigationController(rootViewController: UIViewController())
        sut = LoginViewController(viewModel: self.dependencyAssembler.makeLoginViewModel(coordinator: MockAuthenticateCoordinator(navigationController: navigationController)))
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testLoginViewController_WhenCreated_HasTextField() {
        
        let view = sut.contentView
        
        XCTAssertEqual(view.txtID.text, "")
        XCTAssertEqual(view.txtSecret.text, "")
    }
    
    func testLoginViewController_WhenCreated_HasLoginButtonandActive() {
        
        let view = sut.contentView
        
        let loginButton: UIButton = try! XCTUnwrap(view.btnSubmit, "LoginButton does not have refrence")
        let action = try! XCTUnwrap(loginButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        XCTAssertEqual(action.count, 1)
    }
    
    func testTextId_WhenCreated_HasIdBorderType() {
        
        let view = sut.contentView
        
        let idTextField = try! XCTUnwrap(view.txtID, "idTextFieldNotConnected")
        
        XCTAssertEqual(idTextField.borderStyle, .line)
    }
    
    func testTextISecret_WhenCreated_HasSecretSecureInput() {
        
        let view = sut.contentView
        
        let secretTextField = try! XCTUnwrap(view.txtSecret, "secretTextFieldNotConnected")
        
        XCTAssertEqual(secretTextField.isSecureTextEntry, true)
    }
}
