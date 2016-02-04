//
//  MasterViewController.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController, FileQueueDelegate {

    var files: [SubtitleFile] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let v = self.view as? MovieDraggable {
            v.delegate = self
        }
    }

    func queueFile(path: String) {
        files.append(SubtitleFile(path: path, status: .Pending))
        self.view.needsDisplay = true
    }
    
}
