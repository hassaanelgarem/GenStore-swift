//
//  Type.swift
//  StoreGeneratorCore
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
        var string = ""
        for type in allCases {
            string += "\n\(type.rawValue)"
        }
        return string
    }
}

extension Type: CaseIterable { }
