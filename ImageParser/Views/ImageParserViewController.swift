//
//  Copyright © 2017 Stepanov Pavel. All rights reserved.
//

import Cocoa
import Foundation

final class ImageParserViewController: NSViewController {
    // MARK: - Injected
/** Note:
 Could be injected from outside to tweak the behaviour or for the tests
 */
    lazy var filesWorker = FilesWorker()
    lazy var fileNamesFormatter: FileNamesFormatter = BaseFilesNamesFormatter()
    
    // MARK: - UI
    @IBOutlet var inputTextField: NSTextField!
    @IBOutlet weak var outputTextView: NSTextView!
    @IBOutlet weak var activityIndicator: NSProgressIndicator!
    @IBOutlet weak var statusLabel: NSTextField!
    
    // MARK: - View lifecycle
    override func viewWillAppear() {
        super.viewWillAppear()
        _ = inputTextField.becomeFirstResponder()
        statusLabel.isHidden = true
        
    }
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: NSButton) {
        outputTextView.string = ""
        
        startLoadingAnimation()
        
        toggleStatus(status: .inProgress)
        filesWorker
            .getFilesFrom(path: inputTextField.stringValue,
                                 success: { [weak self] (filesNames) in
                                    guard let strongSelf = self else { return }
                                    let output = strongSelf.fileNamesFormatter.processFileNames(filesNames)
                                    strongSelf.outputTextView.string = output
                                    strongSelf.toggleStatus(status: .success)
                                    strongSelf.finishLoadingAnimation()
        }) { [weak self] (error) in
            self?.toggleStatus(status: .failure(error))
            self?.finishLoadingAnimation()
        }
    }
    
    @IBAction func radioButtonTapped(_ sender: NSButton) {
        guard let bundleMode = BundleMode(rawValue: sender.tag) else { return }
        switch bundleMode {
        case .oneBundle:
            fileNamesFormatter = BaseFilesNamesFormatter()
        case .manyBundles:
            fileNamesFormatter = MultiBundleFileNamesFormatter()
        }
    }
}

// MARK: - UI Helpers
private extension ImageParserViewController {
    func startLoadingAnimation() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimation(nil)
    }
    
    func finishLoadingAnimation() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimation(nil)
    }
    
    func toggleStatus(status: ParsingStatus) {
        statusLabel.isHidden = false
        let color: NSColor
        let text: String
        
        switch status {
        case .inProgress:
            text = AppTexts.inProgress
            color = NSColor.headerColor
        case .success:
            text = AppTexts.success
            color = NSColor.systemGreen
        case .failure(let error):
            let errorDescription = error?.localizedDescription ?? "unknown error"
            text = AppTexts.errorOccured + ": " + errorDescription
            color = NSColor.systemRed
        }
        
        statusLabel.textColor = color
        statusLabel.stringValue = text
    }
}

