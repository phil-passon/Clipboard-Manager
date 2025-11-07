# 📝 Clipboard Manager

A lightweight **macOS clipboard manager** built with **SwiftUI** and **AppKit**.
Keep track of your clipboard history and quickly paste recent items—all from a sleek menu bar popover.

> ⚠️ Note: The app currently integrates the [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) package, but global shortcuts are not fully implemented yet. This project is a learning exercise in Swift.

---

## ✨ Features

* ✅ **Monitors** the system clipboard and stores up to **50 recent items**.
* ✅ **View and expand** truncated clipboard entries.
* ✅ **Select and copy** any item instantly to the system clipboard.
* ✅ Open a **main window** for easier management of your clipboard history.
* ✅ Lightweight, native macOS design with **menu bar access**.
* ⚡ **Keyboard shortcuts** planned (via the `KeyboardShortcuts` package).

---

## 🚀 Installation

1.  Clone the repository:
    ```bash
    git clone [https://github.com/yourusername/ClipboardManager.git](https://github.com/yourusername/ClipboardManager.git)
    ```
2.  Open the project in Xcode:
    ```bash
    open ClipboardManager.xcodeproj
    ```
3.  Build and run the app on macOS 11.0+.

---

## 📖 Usage

1.  Launch the app. A clipboard icon appears in the menu bar.
2.  Click the icon to open the popover:
    * Scroll through your recent items.
    * Tap an item to select it (copies to the system clipboard).
    * Click a truncated item to expand it.
3.  Click **Open Main Window** to view all clipboard history in a separate, persistent window.

> Note: Keyboard shortcuts are not yet fully functional, but the app is ready to integrate them.

---

## 🗂 Project Structure

| File | Purpose |
| :--- | :--- |
| `AppDelegate.swift` | Handles the menu bar icon, popover, and system paste actions. |
| `Clipboard_ManagerApp.swift` | Main SwiftUI app entry point. |
| `ClipboardListView.swift` | Popover UI showing clipboard items. |
| `ClipboardMonitor.swift` | Monitors the clipboard and manages history. |
| `Shortcuts.swift` | Defines global keyboard shortcut names (for `KeyboardShortcuts`). |

---

## ⚙ Requirements

* **macOS** 11.0 or later
* **Xcode** 13 or later
* **Swift** 5.5 or later
* **Dependencies:** `KeyboardShortcuts` package (for planned shortcut integration).
