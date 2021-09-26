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
    func generateStore(sourceFilePath: String, destinationFilePath: String) throws
}

public final class StoreGenerator {
    
    public init() { }
    
    public func run() throws {
        let type = try getType()
        let source = try getArgument(.source)
        let destination = try getArgument(.destination)
        do {
            try type.generator.generateStore(sourceFilePath: source, destinationFilePath: destination)
        } catch let error as Files.FilesError<LocationErrorReason> {
            if error.path == source {
                throw Error.invalidSourcePath
            }
            if destination.contains(error.path) {
                throw Error.invalidDestinationPath
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
        case invalidDestinationPath
        
        public var localizedDescription: String {
            switch self {
            case .missingArgument(argument: let argument):
                return "Missing argument: \(argument.rawValue)"
            case .invalidType:
                // TODO:- Fix this
                return "Invalid type passed. Please use "
            case .invalidSourcePath:
                return "invalidSourcePath"
            case .invalidDestinationPath:
                return "invalidDestinationPath"
            }
        }
    }
}
