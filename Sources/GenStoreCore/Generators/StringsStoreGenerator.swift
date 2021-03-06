//
//  StringsStoreGenerator.swift
//  GenStore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation
import Files

class StringsStoreGenerator: Generator {
    func generateStore(sourceFilePath: String, outputFilePath: String) throws {
        let stringsFile = try File(path: sourceFilePath)
        let storeFile = try File.getOrCreateFile(path: outputFilePath)
        var strings = try stringsFile.readAsString()
        strings = strings.replacingAll(matching: "\"(.*)\" = \"(.*)\";", with: "static let $1 = \"$1\".localized")
        strings = strings.replacingAll(matching: "(.+)\n", with: "\t$0")
        var stringStoreContent = Resources.stringTemplate
        stringStoreContent = stringStoreContent.replacingOccurrences(of: "{data}", with: strings)
        try storeFile.write(stringStoreContent)
    }
}
