//
//  BaseFileNamesFormatter.swift
//  ImageParser
//
//  Created by Pavel Stepanov on 22/08/2018.
//  Copyright © 2018 Stepanov Pavel. All rights reserved.
//

import Foundation

class BaseFilesNamesFormatter: FileNamesFormatter {
    var uiimageInitString: String {
        return "UIImage(named:"
    }
    
    func processFileNames(_ names: [String]) -> String {
        var result: String
        result = "public enum AppImages {\n"
        
        for name in names {
            result += "    public static let \(name): UIImage? = \(uiimageInitString) \"\(name)\")\n"
        }
        
        result += "}"
        return result
    }
}
