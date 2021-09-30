//
//  Type.swift
//  GenStoreCore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation

enum Type: String {
    case colors
    case images
    case strings
    
    var generator: Generator {
        switch self {
        case .strings:
            return StringsStoreGenerator()
        case .colors:
            return ColorsStoreGenerator()
        case .images:
            return ImagesStoreGenerator()
        }
    }
    
    static var allTypesString: String {
        let allTypes = allCases.map {$0.rawValue}.joined(separator: ", ")
        return "[\(allTypes)]"
    }
}

extension Type: CaseIterable { }
