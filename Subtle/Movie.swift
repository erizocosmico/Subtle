//
//  Movie.swift
//  Subtle
//
//  Created by Miguel Molina on 05/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Foundation

let movieExtensions = ["mov", "avi", "mkv", "mp4"]

public func isMovie(path: String) -> Bool {
    if let idx = path.characters.reverse().indexOf(".") {
        let ext = path.substringFromIndex(idx.base)
        return movieExtensions.contains(ext)
    }
    return false
}