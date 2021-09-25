//
//  File+Additions.swift
//  StoreGeneratorCore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation
import Files

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
