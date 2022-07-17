//
//  TokenViewModelTest.swift
//  AmadeusTest
//
//  Created by Mehran on 1/12/1401 AP.
//

import XCTest
import Combine

@testable import Amadeus

class TokenViewModelTest: XCTestCase {
    
    private var mockLogin : MockLogin!
    private var viewModelToTest : LoginViewModel!
    private var bag : Set<AnyCancellable> = []

    override func setUpWithError() throws {
       mockLogin = MockLogin()
       viewModelToTest = LoginViewModel(getTokenService: mockLogin)
    }

    override func tearDownWithError() throws {
        mockLogin = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }
    
    func testGetTokenService() {
        let tokenToTest = GetToken_Response(type: "type", username: "username", application_name: "application_name", client_id: "client_id", token_type: "token_type", access_token: "access_token", expires_in: 15, state: "state", scope: "scope")
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &bag)
        
        mockLogin.fetchedTokenResult = Result.success(tokenToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getTokenData(grant_type: "", client_id: "", client_secret: "")
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTokenWhenNil() {
        let tokenToTest = GetToken_Response()
        let expectation = XCTestExpectation(description: "State is set to Token")
        
        viewModelToTest.loadinState.dropFirst().sink { event in
            XCTAssertEqual(event, .loadStart)
              expectation.fulfill()
        }.store(in: &bag)
        
        mockLogin.fetchedTokenResult = Result.success(tokenToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getTokenData(grant_type: "", client_id: "", client_secret: "")
        
        wait(for: [expectation], timeout: 1)
        
    }
}
