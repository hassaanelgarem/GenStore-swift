//
//  ImagesStoreGenerator.swift
//  StoreGeneratorCore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation
import Files

class ImagesStoreGenerator: Generator {
    
    static let imageSetSuffix = ".imageset"
    
    func generateStore(sourceFilePath: String, outputFilePath: String) throws {
        let imageVariables = try getImages(sourceFilePath: sourceFilePath).map({ (imageName) -> String in
            return """
            \tstatic let \(imageName): UIImage? = UIImage(named: "\(imageName)")
            """
        })
        let string = imageVariables.joined(separator: "\n")
        
        let storeFile = try File.getOrCreateFile(path: outputFilePath)
        var storeContent = Resources.imagesTemplate
        storeContent = storeContent.replacingOccurrences(of: "{data}", with: string)
        try storeFile.write(storeContent)
    }
    
    private func getImages(sourceFilePath: String) throws -> [String] {
        let assetsFolder = try Folder(path: sourceFilePath)
        let colorFolders = assetsFolder.subfolders.filter { (folder) -> Bool in
            folder.name.hasSuffix(Self.imageSetSuffix)
        }
        let colors = colorFolders.map { (folder) -> String in
            return folder.name.replacingOccurrences(of: Self.imageSetSuffix, with: "")
        }
        return colors
    }
}
