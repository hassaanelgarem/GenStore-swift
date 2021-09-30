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
    
    public static var configuration = CommandConfiguration(
        commandName: Constants.commandName,
        abstract: Constants.commandAbstract,
        discussion: Constants.commandDiscussion,
        version: Constants.commandVersion)

    @Option(name: .shortAndLong, help: .typeHelp)
    var type: String
    
    @Option(name: .shortAndLong, help: .sourceHelp)
    var source: String
    
    @Option(name: .shortAndLong, help: .outputHelp)
    var output: String

    public mutating func run() throws {
        let storeGenerator = StoreGenerator(type: type, source: source, output: output)
        try storeGenerator.run()
    }
}

extension ArgumentHelp {
    
    static var typeHelp: ArgumentHelp {
        return ArgumentHelp(Constants.typeOptionHelp,
                            discussion: Constants.typeOptionDiscussion)
    }
    
    static var sourceHelp: ArgumentHelp {
        return ArgumentHelp(Constants.sourceOptionHelp,
                            discussion: Constants.sourceOptionDiscussion)
    }
    
    static var outputHelp: ArgumentHelp {
        return ArgumentHelp(Constants.outputOptionHelp,
                            discussion: Constants.outputOptionDiscussion)
    }
    
}

extension Type: ExpressibleByArgument { }
