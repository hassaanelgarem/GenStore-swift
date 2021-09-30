//
//  TypeTests.swift
//  StoreGeneratorTests
//
//  Created by Hassaan El-Garem on 9/28/21.
//

import XCTest
@testable import StoreGeneratorCore

class TypeTests: XCTestCase {

    func testColorsGenerator() {
        // Given
        let type = Type.colors
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "StoreGeneratorCore.ColorsStoreGenerator")
    }
    
    func testStringsGenerator() {
        // Given
        let type = Type.strings
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "StoreGeneratorCore.StringsStoreGenerator")
    }
    
    func testImagesGenerator() {
        // Given
        let type = Type.images
        
        // When
        let generator = type.generator
        let generatorClass = String(describing: generator)
        
        // Then
        XCTAssertEqual(generatorClass, "StoreGeneratorCore.ImagesStoreGenerator")
    }
    
    func testAllTypes() {
        // When
        let allTypes = Type.allTypesString
        
        // Then
        XCTAssertEqual(allTypes, "[colors, images, strings]")
    }
}
