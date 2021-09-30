//
//  Constants.swift
//  GenStore
//
//  Created by Hassaan El-Garem on 9/30/21.
//

import Foundation

class Constants {
    
    // MARK:- Command Config
    
    static let commandName = "gen-store"
    static let commandAbstract = "A lightweight swift code generator for your resources."
    static let commandDiscussion = "Can be used to create classes for your images, colors and localized strings."
    static let commandVersion = "1.0.0"
    
    // MARK:- Command Options
    
    static let typeOptionHelp = "Type of the store being generated"
    static let typeOptionDiscussion = "Choose one of the following supported types: \(Type.allTypesString)"
    static let sourceOptionHelp = "Path of the source used to generate the store"
    static let sourceOptionDiscussion = "In case of generating a strings store, source should be a .strings file. In case of generating a colors or images store, source should be a .xcassets file"
    static let outputOptionHelp = "Path of the output file"
    static let outputOptionDiscussion = "If a file already exist at this path, it will be overridden, else a new file will be created if possible"
}
