//
//  StoreGenerator.swift
//  Files
//
//  Created by Hassaan El-Garem on 6/7/20.
//

import Foundation
import Files
import Regex
import ArgumentParser

protocol Generator {
    func generateStore(sourceFilePath: String, outputFilePath: String) throws
}

final class StoreGenerator {
    
    // MARK:- Variables
    
    private let typeString: String
    private let source: String
    private let output: String
    
    // MARK:- Initializer
    
    init(type: String, source: String, output: String) {
        self.typeString = type
        self.source = source
        self.output = output
    }
    
    // MARK:- Public Functions
    
    func run() throws {
        let type = try getType(from: typeString)
        do {
            try type.generator.generateStore(sourceFilePath: source, outputFilePath: output)
        } catch let error as Files.FilesError<LocationErrorReason> {
            if error.path.contains(source) {
                throw ValidationError.invalidSourcePath
            }
            if output.contains(error.path) {
                throw ValidationError.invalidOutputPath
            }
            throw error
        }
        print("Successfuly generated \(type.rawValue) store at the provided path!")
    }
    
    // MARK:- Private Helpers
    
    private func getType(from string: String) throws -> Type {
        guard let type = Type(rawValue: string) else {
            throw ValidationError.invalidType
        }
        return type
    }
}

extension ValidationError {
    static var invalidSourcePath = ValidationError("Could not find a valid source at the provided path")
    static var invalidOutputPath = ValidationError("Could not create or find the output file")
    static var invalidType = ValidationError("The type passed is invalid\nChoose one of the following supported types:\(Type.allTypesString)")
}
