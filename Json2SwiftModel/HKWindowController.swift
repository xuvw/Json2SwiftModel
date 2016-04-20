//
//  HKWindowController.swift
//  Json2SwiftModel
//
//  Created by heke on 16/4/17.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Cocoa

class HKWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window?.delegate = self
    }
    
    func windowWillClose(notification: NSNotification) {
        NSApplication.sharedApplication().terminate(nil)
    }
}
