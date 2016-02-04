//
//  Subtitle.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Foundation

enum SubtitleDownloadStatus {
    case Pending, Downloading, Success, Failed
}

struct SubtitleFile {
    var path: String
    var status: SubtitleDownloadStatus
}