//
//  StoreGenerator.swift
//  Files
//
//  Created by Hassaan El-Garem on 6/7/20.
//

import Foundation
import Files
import Regex

protocol Generator {
    func generateStore(sourceFilePath: String, outputFilePath: String) throws
}

public final class StoreGenerator {
    
    public init() { }
    
    public func run() throws {
        let type = try getType()
        let source = try getArgument(.source)
        let output = try getArgument(.output)
        do {
            try type.generator.generateStore(sourceFilePath: source, outputFilePath: output)
        } catch let error as Files.FilesError<LocationErrorReason> {
            if error.path == source {
                throw Error.invalidSourcePath
            }
            if output.contains(error.path) {
                throw Error.invalidOutputPath
            }
            throw error
        }
        print("Successfuly generated \(type.rawValue) store at the provided path!")
    }
    
    // MARK:- Private Functions
    
    private func getType() throws -> Type {
        let typeArgument = try getArgument(.type)
        guard let type = Type(rawValue: typeArgument) else {
            throw Error.invalidType
        }
        return type
    }
    
    private func getArgument(_ argument: Argument) throws -> String  {
        let arguments = UserDefaults.standard
        var value: String?
        if let shortArgument = arguments.string(forKey: argument.shortArgument)  {
            value = shortArgument
        }
        else {
            if let longArgument = arguments.string(forKey: argument.longArgument)  {
                value = longArgument
            }
        }
        guard let value = value else {
            throw Error.missingArgument(argument: argument)
        }
        return value
    }
}

public extension StoreGenerator {
    enum Error: Swift.Error {
        case missingArgument(argument: Argument)
        case invalidType
        case invalidSourcePath
        case invalidOutputPath
        
        public var localizedDescription: String {
            switch self {
            case .missingArgument(argument: let argument):
                return "The following argument is missing: \(argument.rawValue)\nUse -\(argument.shortArgument) or -\(argument.longArgument) to pass it"
            case .invalidType:
                return "The type passed is invalid\nChoose one of the following supported types:\(Type.allTypesString)"
            case .invalidSourcePath:
                return "Could not find a valid source at the provided path"
            case .invalidOutputPath:
                return "Could not create or find the output file"
            }
        }
    }
}
