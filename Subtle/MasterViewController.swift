//
//  MasterViewController.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa
import Subtitler

class MasterViewController: NSViewController {

    var files: [SubtitleFile] = []
    var lastConsumed = -1
    var client: Subtitler?
    var busy = false

    @IBOutlet weak var filesTableView: NSTableView!
    @IBOutlet weak var intro: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let v = self.view as? MovieDraggable {
            v.delegate = self
        }

        self.client = Subtitler(lang:"en", userAgent:"OSTestUserAgent")
        filesTableView.layer?.hidden = true
    }

    func consumeFile() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        guard lastConsumed < files.count-1 && !busy else {
            return
        }

        busy = true
        let row = lastConsumed + 1
        files[row].status = .Downloading
        reload(row)
        lastConsumed += 1

        client?.download(files[row].path) { result in
            switch result {
            case .Success(_):
                self.files[row].status = .Success
            case .Failure(_):
                self.files[row].status = .Failed
            }
            self.reload(row)
            self.busy = false

            self.consumeFile()
        }
    }
    
}

// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return files.count
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView

        switch tableColumn!.identifier {
        case "FileColumn":
            cellView.textField!.stringValue = files[row].fileName()
            cellView.imageView!.image = files[row].statusImage()
            return cellView
        default:
            return cellView
        }
    }

    func reload() {
        self.filesTableView.reloadData()
    }

    func reload(i: Int) {
        self.filesTableView.reloadDataForRowIndexes(NSIndexSet(index: i), columnIndexes: NSIndexSet(index: 0))
    }

    func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        return false
    }

}

// MARK: - FileQueueDelegate

extension MasterViewController: FileQueueDelegate {

    func queueFile(path: String) {
        files.append(SubtitleFile(path: path, status: .Pending))
        intro.layer?.hidden = true
        filesTableView.layer?.hidden = false
        reload()
        consumeFile()
    }

}
