//
//  MovieDraggable.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa

protocol FileQueueDelegate {
    func queueFile(path: String)
}

let movieExtensions = ["mov", "avi", "mkv", "mp4"]

public func isMovie(path: String) -> Bool {
    if let idx = path.characters.reverse().indexOf(".") {
        let ext = path.substringFromIndex(idx.base)
        return movieExtensions.contains(ext)
    }
    return false
}

class MovieDraggable: NSView {

    var delegate: FileQueueDelegate?

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        registerForDraggedTypes([NSFilenamesPboardType])
    }

    override init(frame: NSRect) {
        super.init(frame: frame)
        registerForDraggedTypes([NSFilenamesPboardType])
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }

    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        return NSDragOperation.Copy
    }

    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        let board = sender.draggingPasteboard()
        if let files = board.propertyListForType(NSFilenamesPboardType) as? NSArray {
            for file in files {
                if let path = file as? String {
                    if isMovie(path) {
                        delegate?.queueFile(path)
                    }
                }
            }
            return true
        }
        return false
    }
    
}
