//
//  MultiBundleFileNamesFormatter.swift
//  ImageParser
//
//  Created by Pavel Stepanov on 22/08/2018.
//  Copyright © 2018 Stepanov Pavel. All rights reserved.
//

/**
 Is used when the project consists of more than two bundles and one isconsidered to be a base.
 */
final class MultiBundleFileNamesFormatter: BaseFilesNamesFormatter {
    override var uiimageInitString: String {
        return "UIImage.getImageFromBundles(named:"
    }
    
    override func processFileNames(_ names: [String]) -> String {
        var result = super.processFileNames(names) + "\n\n"
        
        result += "/// Do not forget to implement the function to get images from bundles \n"
        result +=
        """
        /*  extension UIImage {
        public static func getImageFromBundles(named: String) -> UIImage? {
            if let bundleImage = UIImage(named: named) {
                return bundleImage
            } else {
                return UIImage(named: named, in: Bundle.common, compatibleWith: nil)
            }
        }
        
        extension Bundle {
            public static var common: Bundle {
                return Bundle(identifier: "<#Your Bundle Name#>")!
            }
        }
        """
        
        return result
    }
}
