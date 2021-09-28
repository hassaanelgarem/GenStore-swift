//
//  GenerateStoreCommand.swift
//  StoreGeneratorCore
//
//  Created by Hassaan El-Garem on 9/28/21.
//

import Foundation
import ArgumentParser

public struct GenerateStoreCommand: ParsableCommand {
    
    public init() { }
    
    public static var configuration = CommandConfiguration(commandName: "gen-store", abstract: "Abstract TBD", discussion: "Discussion TBD", version: "1.0.0")

    @Option(name: .shortAndLong, help: ArgumentHelp("Type of the store being generated", discussion: "Choose one of the following supported types:\(Type.allTypesString)"))
    var type: String
    
    @Option(name: .shortAndLong, help: ArgumentHelp("Path of the source used to generate the store", discussion: "In case of generating a strings store, source should be a .strings file. In case of generating a colors or images store, source should be a .xcassets file"))
    var source: String
    
    @Option(name: .shortAndLong, help: ArgumentHelp("Path of the output file", discussion: "If a file already exist at this path, it will be overridden, else a new file will be created if possible"))
    var output: String

    public mutating func run() throws {
        let storeGenerator = StoreGenerator(type: type, source: source, output: output)
        try storeGenerator.run()
    }
}

extension Type: ExpressibleByArgument { }
