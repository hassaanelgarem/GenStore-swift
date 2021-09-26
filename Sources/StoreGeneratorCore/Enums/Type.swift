//
//  Type.swift
//  StoreGeneratorCore
//
//  Created by Hassaan El-Garem on 9/26/21.
//

import Foundation

enum Type: String {
    case strings
    case colors
    case images
    
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
}
