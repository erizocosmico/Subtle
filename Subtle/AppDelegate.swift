//
//  AppDelegate.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var masterViewController: MasterViewController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        window.contentView?.addSubview(masterViewController.view)
        masterViewController.view.frame = window.contentView!.bounds
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func openDocument(sender: AnyObject?) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.beginWithCompletionHandler { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                openPanel.URLs.map{
                    return $0.absoluteString.substringFromIndex(
                        $0.absoluteString.startIndex.advancedBy(7)
                    )
                }.forEach{ path in
                    self.masterViewController.queueFile(path)
                }
            }
        }
    }

}
