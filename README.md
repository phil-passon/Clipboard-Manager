# 📝 Clipboard Manager

A lightweight **macOS clipboard manager** built with SwiftUI and AppKit.
Keep track of your clipboard history and quickly paste recent items—all from a sleek menu bar popover.

---

## ✨ Features

* ✅ **Monitors** the system clipboard and stores up to 50 recent items.
* ✅ **View and expand** truncated clipboard entries when clicked.
* ✅ **Select and copy** any item instantly to the system clipboard.
* ✅ **Persistent history window** for easier management.
* ✅ Lightweight, native macOS design with **menu bar access**.
* ⚡ **Keyboard shortcuts** planned (via the `KeyboardShortcuts` package).

---

## 🚀 Installation

The project requires Xcode and Swift environment setup.

1.  **Clone** the repository:
    ```bash
    git clone [https://github.com/yourusername/ClipboardManager.git](https://github.com/yourusername/ClipboardManager.git)
    ```
2.  **Open** the project in Xcode:
    ```bash
    open ClipboardManager.xcodeproj
    ```
3.  **Build and run** the app on macOS 11.0+.

---

## 📖 Usage

1.  Launch the app. A **clipboard icon** appears in the menu bar.
2.  Click the icon to open the popover. Inside the popover:
    * **Scroll** through your recent items.
    * **Click** a truncated item to expand it to full text.
    * **Tap** an item to copy it to the system clipboard.

> **Note:** Keyboard shortcuts (`Command-Shift-V`, etc.) are planned but not yet fully functional.

---

## 🗂 Project Structure

| File | Purpose |
| :--- | :--- |
| `AppDelegate.swift` | Handles the menu bar icon, popover presentation, and paste actions. |
| `Clipboard_ManagerApp.swift` | Main SwiftUI app entry point and lifecycle setup. |
| `ClipboardListView.swift` | The primary popover UI showing clipboard items and controls. |
| `ClipboardMonitor.swift` | Monitors the system clipboard and manages the history array. |
| `Shortcuts.swift` | (Planned) Defines the global keyboard shortcut names. |

---

## ⚙ Requirements

* **macOS** 11.0 or later
* **Xcode** 13 or later
* **Swift** 5.5 or later
* **Dependencies:** `KeyboardShortcuts` package (for planned shortcut integration).
