//
//  StoreGeneratorTests.swift
//  StoreGeneratorTests
//
//  Created by Hassaan El-Garem on 9/28/21.
//

import XCTest
import Files
@testable import StoreGeneratorCore
import ArgumentParser

class StoreGeneratorTests: XCTestCase {

    var tempFolder: Folder?
    
    override func setUpWithError() throws {
        let testBundle = Bundle(for: type(of: self))
        let resourcesUrl = testBundle.resourceURL
        let resourcesFolder = try Folder(path: resourcesUrl?.deletingLastPathComponent().path ?? "")
        tempFolder = try resourcesFolder.createSubfolder(named: "temp")
    }
    
    override func tearDownWithError() throws {
        try tempFolder?.delete()
    }

    func testInvalidType() throws {
        // Given
        let generator = StoreGenerator(type: "invalid", source: "", output: "")
        
        // When & Then
        XCTAssertThrowsError(try generator.run(), "Expected error is not thrown") { error in
            guard let error = error as? ValidationError else {
                XCTFail("Error is of wrong type")
                return
            }
            XCTAssertEqual(error.message, "The type passed is invalid\nChoose one of the following supported types: [colors, images, strings]")
        }
    }
    
    func testInvalidSource() throws {
        // Given
        let sourcePath = "test/invalid.strings"
        guard let outputPath = tempFolder?.url.appendingPathComponent("output.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        let generator = StoreGenerator(type: "strings", source: sourcePath, output: outputPath)
        
        // When & Then
        XCTAssertThrowsError(try generator.run(), "Expected error is not thrown") { error in
            guard let error = error as? ValidationError else {
                XCTFail("Error is of wrong type")
                return
            }
            XCTAssertEqual(error.message, "Could not find a valid source at the provided path")
        }
    }
    
    func testInvalidFolderSource() throws {
        // Given
        let sourcePath = "test/invalid.xcassets"
        guard let outputPath = tempFolder?.url.appendingPathComponent("output.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        let generator = StoreGenerator(type: "colors", source: sourcePath, output: outputPath)
        
        // When & Then
        XCTAssertThrowsError(try generator.run(), "Expected error is not thrown") { error in
            guard let error = error as? ValidationError else {
                XCTFail("Error is of wrong type")
                return
            }
            XCTAssertEqual(error.message, "Could not find a valid source at the provided path")
        }
    }
    
    func testInvalidOutput() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        guard let sourcePath = testBundle.path(forResource: "StringsSource", ofType: "strings") else {
            XCTFail("Couldn't find source file")
            return
        }
        let outputPath = "/invalid/test.swift"
        let generator = StoreGenerator(type: "strings", source: sourcePath, output: outputPath)
        
        // When & Then
        XCTAssertThrowsError(try generator.run(), "Expected error is not thrown") { error in
            guard let error = error as? ValidationError else {
                XCTFail("Error is of wrong type")
                return
            }
            XCTAssertEqual(error.message, "Could not create or find the output file")
        }
    }
    
    func testGeneratingStringsStore() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        guard let sourcePath = testBundle.path(forResource: "StringsSource", ofType: "strings") else {
            XCTFail("Couldn't find source file")
            return
        }
        guard let expectedOutputPath = testBundle.path(forResource: "StringStoreOutput", ofType: "txt") else {
            XCTFail("Couldn't find expected file")
            return
        }
        guard let outputPath = tempFolder?.url.appendingPathComponent("stringsOutput.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        let generator = StoreGenerator(type: "strings", source: sourcePath, output: outputPath)
        
        // When
        try generator.run()
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: outputPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }
    
    func testGeneratingColorsStore() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        guard let sourcePath = testBundle.path(forResource: "AssetsSource", ofType: "xcassets") else {
            XCTFail("Couldn't find source file")
            return
        }
        guard let expectedOutputPath = testBundle.path(forResource: "ColorsStoreOutput", ofType: "txt") else {
            XCTFail("Couldn't find expected file")
            return
        }
        guard let outputPath = tempFolder?.url.appendingPathComponent("colorsOutput.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        let generator = StoreGenerator(type: "colors", source: sourcePath, output: outputPath)
        
        // When
        try generator.run()
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: outputPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }
    
    func testGeneratingImagesStore() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        guard let sourcePath = testBundle.path(forResource: "AssetsSource", ofType: "xcassets") else {
            XCTFail("Couldn't find source file")
            return
        }
        guard let expectedOutputPath = testBundle.path(forResource: "ImagesStoreOutput", ofType: "txt") else {
            XCTFail("Couldn't find expected file")
            return
        }
        guard let outputPath = tempFolder?.url.appendingPathComponent("imagesOutput.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        let generator = StoreGenerator(type: "images", source: sourcePath, output: outputPath)
        
        // When
        try generator.run()
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: outputPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }

}
