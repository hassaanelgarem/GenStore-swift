import XCTest
import Files
import class Foundation.Bundle

final class StoreGeneratorCommandLineTests: XCTestCase {
    
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
    
    func testMissingType() throws {
        // When
        let output = try runCommandWithArguments([])

        // Then
        XCTAssertEqual(output, "Whoops! An error occurred: Missing argument: type\n")
    }
    
    func testMissingSource() throws {
        // When
        let output = try runCommandWithArguments(["-t", "colors"])

        // Then
        XCTAssertEqual(output, "Whoops! An error occurred: Missing argument: source\n")
    }
    
    func testMissingDestination() throws {
        // When
        let output = try runCommandWithArguments(["-t", "colors", "-s", "test"])

        // Then
        XCTAssertEqual(output, "Whoops! An error occurred: Missing argument: destination\n")
    }
    
    func testInvalidType() throws {
        // When
        let output = try runCommandWithArguments(["-t", "invalid"])

        // Then
        XCTAssertEqual(output, "Whoops! An error occurred: Invalid type passed. Please use \n")
    }
    
    func testGeneratingStoreFile() throws {
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
        guard let destinationPath = tempFolder?.url.appendingPathComponent("stringsOutput.swift").path else {
            XCTFail("Couldn't create destination path")
            return
        }
        
        // When
        let _ = try runCommandWithArguments(["-t", "strings", "-s", sourcePath, "-d", destinationPath])
        
        // Then
        let expectedString = try File(path: expectedOutputPath).readAsString(encodedAs: .utf8).replacingOccurrences(of: "\\t", with: "\t")
        let actualString = try File(path: destinationPath).readAsString(encodedAs: .utf8)
        XCTAssertEqual(actualString, expectedString)
    }
    
    // MARK:- Helpers

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
    
    func runCommandWithArguments(_ arguments: [String]) throws -> String? {
        guard #available(macOS 10.13, *) else {
            return nil
        }

        let fooBinary = productsDirectory.appendingPathComponent("StoreGenerator")

        let process = Process()
        process.executableURL = fooBinary
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe
        

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        return output
    }
}
