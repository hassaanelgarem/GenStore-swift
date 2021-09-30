//
//  ArgumentTests.swift
//  GenStoreTests
//
//  Created by Hassaan El-Garem on 9/28/21.
//

import XCTest
@testable import GenStoreCore

class ArgumentTests: XCTestCase {
    
    func testTypeArgument() {
        // Given
        let argument = Argument.type
        
        // When
        let shortArgument = argument.shortArgument
        let longArgument = argument.longArgument
        
        // Then
        XCTAssertEqual(shortArgument, "t")
        XCTAssertEqual(longArgument, "-type")
    }
    
    func testSourceArgument() {
        // Given
        let argument = Argument.source
        
        // When
        let shortArgument = argument.shortArgument
        let longArgument = argument.longArgument
        
        // Then
        XCTAssertEqual(shortArgument, "s")
        XCTAssertEqual(longArgument, "-source")
    }
    
    func testOutputArgument() {
        // Given
        let argument = Argument.output
        
        // When
        let shortArgument = argument.shortArgument
        let longArgument = argument.longArgument
        
        // Then
        XCTAssertEqual(shortArgument, "o")
        XCTAssertEqual(longArgument, "-output")
    }
}
