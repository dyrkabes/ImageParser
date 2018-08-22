//
//  ParsingStatus.swift
//  ImageParser
//
//  Created by Pavel Stepanov on 22/08/2018.
//  Copyright © 2018 Stepanov Pavel. All rights reserved.
//

import Foundation

enum ParsingStatus {
    case inProgress
    case success
    case failure(Error?)
}
