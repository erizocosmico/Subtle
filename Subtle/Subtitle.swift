//
//  Subtitle.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Foundation
import Cocoa

enum SubtitleDownloadStatus {
    case Pending, Downloading, Success, Failed
}

struct SubtitleFile {
    
    var path: String
    var status: SubtitleDownloadStatus

    func statusImage() -> NSImage {
        return NSImage(named: String(status))!
    }

    func fileName() -> String {
        if let idx = path.characters.reverse().indexOf("/") {
            return path.substringFromIndex(idx.base)
        }
        return ""
    }

}