//
//  HGStringStoreGenerator.swift
//  Files
//
//  Created by Hassaan El-Garem on 6/7/20.
//

import Foundation
import Files
import Regex

private enum Type: String {
    case strings
    case colors
}

public enum Argument: String {
    case type
    case source
    case destination
    
    var shortArgument: String {
        guard let firstLetter = self.rawValue.first else {
            return "Invalid"
        }
        return String(firstLetter)
    }
    
    var longArgument: String {
        return "-\(self.rawValue)"
    }
}

public final class HGStringStoreGenerator {
    static let colorSetSuffix = ".colorset"
    
    public init() { }
    
    public func run() throws {
        let type = try getType()
        let source = try getArgument(.source)
        let destination = try getArgument(.destination)
        switch type {
        case .strings:
            try generateStringStore(sourceFilePath: source, destinationFilePath: destination)
            break
        case .colors:
            try generateColorStore(sourceFilePath: source, destinationFilePath: destination)
            break
        }
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
    
    private func generateStringStore(sourceFilePath: String, destinationFilePath: String) throws {
        let stringsFile = try File(path: sourceFilePath)
        let storeFile = try File.getOrCreateFile(path: destinationFilePath)
        var strings = try stringsFile.readAsString()
        strings = strings.replacingAll(matching: "\"(.*)\" = \"(.*)\";", with: "static let $1 = \"$1\".localized")
        var stringStoreContent = Resources.stringTemplate
        stringStoreContent = stringStoreContent.replacingOccurrences(of: "{data}", with: strings)
        try storeFile.write(stringStoreContent)
    }
    
    private func generateColorStore(sourceFilePath: String, destinationFilePath: String) throws {
        let colorCases = try getColors(sourceFilePath: sourceFilePath).map({ (color) -> String in
            return "case \(color)"
        })
        let string = colorCases.joined(separator: "\n\t")
        
        let storeFile = try File(path: destinationFilePath)
        var storeContent = Resources.colorTemplate
        storeContent = storeContent.replacingOccurrences(of: "{data}", with: string)
        try storeFile.write(storeContent)
    }
    
    private func getColors(sourceFilePath: String) throws -> [String] {
        let assetsFolder = try Folder(path: sourceFilePath)
        let colorFolders = assetsFolder.subfolders.filter { (folder) -> Bool in
            folder.name.hasSuffix(Self.colorSetSuffix)
        }
        let colors = colorFolders.map { (folder) -> String in
            return folder.name.replacingOccurrences(of: Self.colorSetSuffix, with: "")
        }
        return colors
    }
}



public extension HGStringStoreGenerator {
    enum Error: Swift.Error {
        case missingArgument(argument: Argument)
        case invalidType
        
        public var localizedDescription: String {
            switch self {
            case .missingArgument(argument: let argument):
                return "Missing argument: \(argument.rawValue)"
            case .invalidType:
                // TODO:- Fix this
                return "Invalid type passed. Please use "
            }
        }
    }
}

extension File {
    func readAsString() throws -> String {
        guard let string = try? self.readAsString(encodedAs: .utf8) else {
            return try self.readAsString(encodedAs: .utf16)
        }
        return string
    }
    
    static func getOrCreateFile(path: String) throws -> File {
        let fileURL = URL(fileURLWithPath: path)
        let fileName = fileURL.lastPathComponent
        let parentURL = fileURL.deletingLastPathComponent()
        let parentFolder = try Folder(path: parentURL.path)
        return try parentFolder.createFileIfNeeded(withName: fileName)
    }
}
