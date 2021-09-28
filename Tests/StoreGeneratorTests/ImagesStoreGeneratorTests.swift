//
//  ImagesStoreGeneratorTests.swift
//  StoreGeneratorTests
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import XCTest
import Files
@testable import StoreGeneratorCore

class ImagesStoreGeneratorTests: XCTestCase {
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
    
    func testGenerateStore() throws {
        // Given
        let generator = ImagesStoreGenerator()
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
        
        // When
        try generator.generateStore(sourceFilePath: sourcePath, outputFilePath: outputPath)
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: outputPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }
    
    func testGenerateEmptyStore() throws {
        // Given
        let generator = ImagesStoreGenerator()
        let testBundle = Bundle(for: type(of: self))
        guard let sourcePath = testBundle.path(forResource: "EmptyAssetsSource", ofType: "xcassets") else {
            XCTFail("Couldn't find source file")
            return
        }
        guard let expectedOutputPath = testBundle.path(forResource: "EmptyImagesStoreOutput", ofType: "txt") else {
            XCTFail("Couldn't find expected file")
            return
        }
        guard let outputPath = tempFolder?.url.appendingPathComponent("imagesOutput.swift").path else {
            XCTFail("Couldn't create output path")
            return
        }
        
        // When
        try generator.generateStore(sourceFilePath: sourcePath, outputFilePath: outputPath)
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: outputPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }
}
