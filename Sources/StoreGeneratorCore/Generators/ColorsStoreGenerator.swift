//
//  ColorsStoreGenerator.swift
//  StoreGeneratorCore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation
import Files

class ColorsStoreGenerator: Generator {
    
    static let colorSetSuffix = ".colorset"
    
    func generateStore(sourceFilePath: String, outputFilePath: String) throws {
        let colorVariables = try getColors(sourceFilePath: sourceFilePath).map({ (colorName) -> String in
            return "\tstatic let \(colorName): UIColor = Self.unwrappedColor(named: \"\(colorName)\")"
        })
        let string = colorVariables.joined(separator: "\n")
        
        let storeFile = try File.getOrCreateFile(path: outputFilePath)
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
