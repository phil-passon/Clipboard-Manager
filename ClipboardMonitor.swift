//
//  ClipboardMonitor.swift
//  Clipboard Manager
//
//  Created by Phil Passon on 07.11.25.
//

import Cocoa
import SwiftUI
import Combine

class ClipboardMonitor: ObservableObject {
    
    // Published array of copied text items
    @Published var history: [String] = []
    
    private var lastChangeCount: Int = 0
    private var timer: Timer?
    private let maxHistorySize = 50 // Limit the size of the history
    
    // MARK: - Monitoring
    
    func startMonitoring() {
        // Stop any existing timer
        timer?.invalidate()
        
        // Start a new timer to check the pasteboard every 0.5 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkPasteboard()
        }
    }
    
    private func checkPasteboard() {
        let pasteboard = NSPasteboard.general
        
        // Check if the pasteboard content has changed
        if pasteboard.changeCount != lastChangeCount {
            
            // Only accept text strings
            if let newString = pasteboard.string(forType: .string) {
                
                // Trim leading/trailing whitespace
                let trimmedString = newString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Only add if it's not empty and not the same as the most recent item
                if !trimmedString.isEmpty && history.first != trimmedString {
                    
                    // Remove duplicate if it exists elsewhere in history
                    if let existingIndex = history.firstIndex(of: trimmedString) {
                        history.remove(at: existingIndex)
                    }
                    
                    // Add new item to the top
                    history.insert(trimmedString, at: 0)
                    
                    // Enforce history size limit
                    if history.count > maxHistorySize {
                        history.removeLast()
                    }
                }
                
                lastChangeCount = pasteboard.changeCount
            }
        }
    }
    
    // MARK: - Actions
    
    func paste(at index: Int) {
        guard index < history.count else { return }
        
        let textToPaste = history[index]
        
        // 1. Copy the selected text to the system pasteboard
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(textToPaste, forType: .string)
    }
}
