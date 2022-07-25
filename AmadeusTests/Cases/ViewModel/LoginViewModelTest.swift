//
//  LoginViewModelTest.swift
//  AmadeusTest
//
//  Created by Mehran on 1/12/1401 AP.
//

import XCTest
import Combine

@testable import Amadeus

class LoginViewModelTest: XCTestCase {
    
    private var mockLogin : MockLogin!
    private var viewModelToTest : LoginViewModel!
    private var subscriber : Set<AnyCancellable> = []
    
    override func setUp()  {
        mockLogin = MockLogin()
        viewModelToTest = LoginViewModel(getTokenService: mockLogin)
    }
    
    override func tearDown() {
        subscriber.forEach { $0.cancel() }
        subscriber.removeAll()
        mockLogin = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testLoginViewModelUsername_WhenUserNameisInvalid_ShouldReturnNil() {
        viewModelToTest.userName = ""
        
        viewModelToTest.validateUserName
            .sink { value in
                XCTAssertTrue(value as Any is String)
                XCTAssertNil(value)
            }.store(in: &subscriber)
    }
    
    func testLoginViewModelPassword_WhenPasswordisInvalid_ShouldReturnNil() {
        viewModelToTest.userName = ""
        
        viewModelToTest.validateUserName
            .sink { value in
                XCTAssertTrue(value as Any is String)
                XCTAssertNil(value)
            }.store(in: &subscriber)
    }
    
    func testLoginViewModelService_WhenServieCalled_ShouldReturnResponse() {
        let tokenToTest = GetToken_Response(type: "type", username: "username", application_name: "application_name", client_id: "client_id", token_type: "token_type", access_token: "access_token", expires_in: 15, state: "state", scope: "scope")
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
            expectation.fulfill()
        }.store(in: &subscriber)
        
        mockLogin.fetchedTokenResult = Result.success(tokenToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getTokenData(grant_type: "", client_id: "", client_secret: "")
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoginViewModelService_WhenServieCalled_ShouldReturnNil() {
        
        let tokenToTest = GetToken_Response()
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
            expectation.fulfill()
        }.store(in: &subscriber)
        
        mockLogin.fetchedTokenResult = Result.success(tokenToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getTokenData(grant_type: "", client_id: "", client_secret: "")
        
        wait(for: [expectation], timeout: 1)
        
    }
}
