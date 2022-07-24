//
//  ObfuscatorTest.swift
//  AmadeusTests
//
//  Created by Mehran Kamalifard on 7/24/22.
//

import XCTest
@testable import Amadeus

class ObfuscatorTest: XCTestCase {
    
    var sut : ObfuscatorProtocol!
    
    override func setUp() {
        super.setUp()
        sut = Obfuscator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testBytesByObfuscatingString_WhenCelled_ShouldReturnValidByteArray() {
        let result = sut.bytesByObfuscatingString(string: "obfuscator")
        XCTAssertTrue(result as Any is [UInt8])
        XCTAssertEqual(result.count, "obfuscator".count)
    }
    
    func testreveal_WhenCalled_SouldReturnValidString() {
        let value = sut.bytesByObfuscatingString(string: "obfuscator")
        let result = sut.reveal(key: value)
        XCTAssertTrue(result as Any is String)
        XCTAssertEqual(result, "obfuscator")
    }
}
