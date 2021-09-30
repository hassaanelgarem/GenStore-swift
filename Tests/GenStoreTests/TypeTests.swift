//
//  TypeTests.swift
//  GenStoreTests
//
//  Created by Hassaan El-Garem on 9/28/21.
//

import XCTest
@testable import GenStoreCore

class TypeTests: XCTestCase {

    func testColorsGenerator() {
        // Given
        let type = Type.colors
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "GenStoreCore.ColorsStoreGenerator")
    }
    
    func testStringsGenerator() {
        // Given
        let type = Type.strings
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "GenStoreCore.StringsStoreGenerator")
    }
    
    func testImagesGenerator() {
        // Given
        let type = Type.images
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "GenStoreCore.ImagesStoreGenerator")
    }
    
    func testAllTypes() {
        // When
        let allTypes = Type.allTypesString
        
        // Then
        XCTAssertEqual(allTypes, "[colors, images, strings]")
    }
}
