//
//  AppDelegate.swift
//  Subtle
//
//  Created by Miguel Molina on 03/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa
import MASPreferences

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var masterViewController: MasterViewController!
    private var preferencesWindow: MASPreferencesWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        window.contentView?.addSubview(masterViewController.view)
        masterViewController.view.frame = window.contentView!.bounds
        self.window.styleMask = self.window.styleMask | NSFullSizeContentViewWindowMask
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

// MARK - Actions
extension AppDelegate {

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
                        if isMovie(path) {
                            self.masterViewController.queueFile(path)
                        }
                }
            }
        }
    }

    @IBAction func openPreferences(sender: AnyObject?) {
        preferencesWindowController().showWindow(nil)
    }

}

// Mark - MASPreferences
extension AppDelegate {

    func preferencesWindowController() -> NSWindowController {
        if preferencesWindow == nil {
            let controllers = [LanguagePreferencesViewController()]
            preferencesWindow = MASPreferencesWindowController(viewControllers: controllers, title: "Preferences")
        }
        return preferencesWindow!
    }

}
