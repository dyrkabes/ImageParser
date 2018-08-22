//
//  Copyright © 2017 Stepanov Pavel. All rights reserved.
//

/**
 Helper that allows us to make image names from designer resources pack.
 
 - Usage:
 0. Run the project :)
 1. Download the resources pack.
 2. Drag and drop the folder to the inputTextField.
 3. Hit "Make names" button.
 4. Copy all the code from the big outputTextView,
 5. Create a AppImages files in your project and paste it there (you could name it whatever you want of course :) ).
 6. Don't forget to drag and drop the folder with the images to your assets
 */

// TODO: Fixing corrupted names
// TODO: Show error/success label
// TODO: Work with bundles and getImages func

/* Helper file

 extension UIImage {
     public static func getImageFromBundles(named: String) -> UIImage? {
         if let bundleImage = UIImage(named: named) {
         return bundleImage
     } else {
         return UIImage(named: named, in: Bundle.common, compatibleWith: nil)
     }
 }
*/

import Cocoa
import Foundation

final class ImageParserViewController: NSViewController {
    // MARK: - UI
    @IBOutlet var inputTextField: NSTextField!
    @IBOutlet weak var outputTextView: NSTextView!
    @IBOutlet weak var activityIndicator: NSProgressIndicator!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        _ = inputTextField.becomeFirstResponder()
    }
    
    @IBAction func buttonTapped(_ sender: NSButton) {
        var filesArray: [String] = []
        outputTextView.string = ""
        activityIndicator.isHidden = false
        activityIndicator.startAnimation(nil)
        
        defer {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimation(nil)
        }
        
        do {
            try Folder(path: inputTextField.stringValue)
                .makeSubfolderSequence(recursive: true, includeHidden: true)
                .forEach { folder in
                folder.files.forEach { file in
                    let fileName = file.nameExcludingExtension
                    // Appending only files w/o "@" symbol as we have 3 copies of every image
                    if !fileName.contains("@") {
                        filesArray.append(fileName)
                    }
                }
            }
        } catch {
            print(" *** ERROR: \(error) \(self.self) \n\(#function) \(#line) \nDate: \(Date())")
        }
        
        outputTextView.string = "public enum AppImages {\n"
        for file in filesArray {
            outputTextView.string += "    public static let \(file): UIImage? = UIImage.getImageFromBundles(named: \"\(file)\")\n"
        }
        
        outputTextView.string += "}"
    }
}

