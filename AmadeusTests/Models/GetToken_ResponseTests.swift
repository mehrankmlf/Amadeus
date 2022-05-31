//
//  GetToken_ResponseTests.swift
//  SappPlusTests
//
//  Created by Mehran Kamalifard on 2/27/22.
//

import XCTest
@testable import Amadeus

class GetToken_ResponseTests: XCTestCase {
    
    var data : GetToken_Response!
    
    override func setUp() {
        super.setUp()
        data = GetToken_Response(type: "type", username: "username", application_name: "application_name", client_id: "client_id", token_type: "token_type", access_token: "access_token", expires_in: 120, state: "state", scope: "scope")
    }
    
    override func tearDown() {
        data = nil
        super.tearDown()
    }
        
    func testConformTo_Decodable() {
        XCTAssertTrue(data as Any is Decodable)
    }
    
    func testConformTo_Equtable() {
      XCTAssertEqual(data, data)
    }
    
    func testValidTokenData() {
        XCTAssertTrue(data.client_id == "client_id")
        XCTAssertTrue(data.access_token == "access_token")
        XCTAssertTrue(data.application_name == "application_name")
    }
}
