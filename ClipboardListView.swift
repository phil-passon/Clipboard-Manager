//
//  ClipboardListView.swift
//  Clipboard Manager
//
//  Created by Phil Passon on 07.11.25.
//

import SwiftUI
import AppKit
import Combine

struct ClipboardListView: View {
    @ObservedObject var monitor = clipboardMonitor
    @State private var expandedIndices: Set<Int> = []
    private let contentPadding: CGFloat = 5
    @State private var lastRequestedSize: CGSize = .zero
    private var appDelegate: AppDelegate? {
        NSApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { proxy in
                ZStack {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 1) { // tiny spacing
                            ForEach(monitor.history.indices, id: \.self) { index in
                                ClipboardItemRow(
                                    text: monitor.history[index],
                                    index: index,
                                    isExpanded: expandedIndices.contains(index),
                                    onToggleExpansion: self.toggleExpansion,
                                    onSelect: self.selectItem
                                )
                            }
                        }
                        .padding(10)
                        Button("Open Main Window") {
                            openMainWindow()
                        }
                    }
                }
                .frame(maxWidth: 600, maxHeight: 500, alignment: .top)
            }
            .frame(maxWidth: 600, maxHeight: 500, alignment: .top)
            .onExitCommand { NSApp.keyWindow?.close() }
        }
        .padding(0)
    }
    
    // MARK: - Actions
    
    private func toggleExpansion(index: Int) {
        if expandedIndices.contains(index) {
            expandedIndices.remove(index)
        } else {
            expandedIndices.insert(index)
        }
    }
    
    private func selectItem(index: Int) {
        monitor.paste(at: index)
        if let appDelegate = appDelegate {
            appDelegate.closePopover(nil)
        }
    }

    private func openMainWindow() {
        guard let appDelegate = appDelegate else { return }
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 500),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Clipboard Manager"
        window.contentView = NSHostingView(rootView: ClipboardListView())
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

// MARK: - Row Subview Definition

struct ClipboardItemRow: View {
    let text: String
    let index: Int
    let isExpanded: Bool
    let onToggleExpansion: (Int) -> Void
    let onSelect: (Int) -> Void

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            // Index
            Text("\(index + 1)")
                .font(.caption2)
                .foregroundColor(.accentColor)
                .fixedSize()

            // Text
            Text(text)
                .font(.body)
                .lineLimit(isExpanded ? nil : 1)
                .truncationMode(.tail)
                .lineSpacing(0)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            // Select button
            Button("Select") {
                onSelect(index)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 2)
        .contentShape(Rectangle())
        .onTapGesture {
            let isTruncated = text.count > 30
            if isExpanded || isTruncated {
                onToggleExpansion(index)
            } else {
                onSelect(index)
            }
        }
    }
}
