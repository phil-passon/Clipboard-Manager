//
//  AppDelegate.swift
//  Clipboard Manager
//
//  Created by Phil Passon on 07.11.25.
//

import Cocoa
import SwiftUI
import KeyboardShortcuts

let clipboardMonitor = ClipboardMonitor()

class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Set up popover
        popover = NSPopover()
        let contentView = ClipboardListView()
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentSize = NSSize(width: 600, height: 500)
        popover.behavior = .transient

        // Set up status bar icon
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "Clipboard Manager")
            button.action = #selector(togglePopover(_:))
            button.sendAction(on: [.leftMouseDown, .rightMouseDown])
        }

        clipboardMonitor.startMonitoring()
    }

    // MARK: - Popover Actions

    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    func showPopover(_ sender: AnyObject?) {
        guard let button = statusItem.button else { return }
        popover.contentSize = NSSize(width: 600, height: 500)
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        NSApp.activate(ignoringOtherApps: true)
    }

    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }

    // MARK: - Paste Action

    public func performPaste(index: Int) {
        clipboardMonitor.paste(at: index)
        closePopover(nil)
    }
}
