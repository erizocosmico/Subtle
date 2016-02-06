//
//  LanguagePreferencesViewController.swift
//  Subtle
//
//  Created by Miguel Molina on 06/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import Cocoa
import MASPreferences

class LanguagePreferencesViewController: NSViewController, MASPreferencesViewController {

    @IBOutlet var dropdown: NSPopUpButton!
    private var defaults: NSUserDefaults?

    override func viewDidLoad() {
        super.viewDidLoad()

        dropdown.addItemsWithTitles(languages.map{ $0.name })
        defaults = NSUserDefaults.standardUserDefaults()
        if let lang = defaults?.objectForKey("language") as? Int {
            dropdown.selectItemAtIndex(lang)
        }
    }

    var toolbarItemImage: NSImage! {
        get { return NSImage(named: NSImageNamePreferencesGeneral)! }
    }

    var toolbarItemLabel: String! {
        get { return NSLocalizedString("General", comment: "Toolbar item name for General preference pane") }
    }

    override var identifier: String? {
        get { return "general" }
        set { super.identifier = newValue }
    }

    @IBAction func onDropdownChange(sender: AnyObject?) {
        if let btn = sender as? NSPopUpButton {
            defaults?.setObject(btn.indexOfSelectedItem, forKey: "language")
            defaults?.synchronize()
        }
    }

}
