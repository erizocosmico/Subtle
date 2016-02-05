//
//  MasterViewController.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa
import Subtitler

class MasterViewController: NSViewController, FileQueueDelegate {

    var files: [SubtitleFile] = []
    var lastConsumed = -1
    var client: Subtitler?
    var busy = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if let v = self.view as? MovieDraggable {
            v.delegate = self
        }

        self.client = Subtitler(lang:"en", userAgent:"OSTestUserAgent")
    }

    func queueFile(path: String) {
        files.append(SubtitleFile(path: path, status: .Pending))
        self.view.needsDisplay = true

        consumeFile()
    }

    func consumeFile() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        guard lastConsumed < files.count-1 && !busy else {
            return
        }

        busy = true
        var file = files[lastConsumed+1]
        file.status = .Downloading
        view.needsDisplay = true;
        lastConsumed += 1

        client?.download(file.path) { result in
            switch result {
            case .Success(_):
                file.status = .Success
            case .Failure(_):
                file.status = .Failed
            }
            self.view.needsDisplay = true;
            self.busy = false

            self.consumeFile()
        }
    }
    
}
