//
//  FilesWorker.swift
//  ImageParser
//
//  Created by Pavel Stepanov on 22/08/2018.
//  Copyright © 2018 Stepanov Pavel. All rights reserved.
//

typealias FileNamesSuccessHandler = ([String]) -> Void
typealias FailureHandler = (Error) -> Void

/**
 Creates a list of all filenames in the folder excluding the ones with the "@" symbol.
 */
struct FilesWorker {
    func getFilesFrom(path: String, success: @escaping FileNamesSuccessHandler, failure: @escaping FailureHandler) {
        var filesArray: [String] = []
        do {
            try Folder(path: path)
                .makeSubfolderSequence(recursive: true, includeHidden: true)
                .forEach { folder in
                    folder.files.forEach { file in
                        let fileName = file.nameExcludingExtension
                        
                        if !fileName.contains("@") {
                            filesArray.append(fileName)
                        }
                    }
            }
            
            success(filesArray)
        } catch {
            failure(error)
        }
    }
}
