//
//  Resources.swift
//  Files
//
//  Created by Hassaan El-Garem on 9/13/20.
//

public final class Resources {
    public static let stringTemplate = """
\(generatedTag)

import Foundation

class StringsStore {

{data}
}

fileprivate extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

"""
    public static let colorTemplate = """
\(generatedTag)

import Foundation
import UIKit

class ColorsStore {

{data}

    static func unwrappedColor(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            print("[ERROR] - Color with name (\\"\\(name)\\") not found in assets cataloug")
            return UIColor.white
        }
        return color
    }
}

"""
    public static let imagesTemplate = """
\(generatedTag)

import UIKit

class ImagesStore {

{data}
}

"""
    
    private static let generatedTag = "//  Automatically generated by StoreGenerator."
}
