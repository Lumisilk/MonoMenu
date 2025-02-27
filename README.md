# MonoMenu

MonoMenu provides two customized presentation styles for iOS applications: popover and dialog.

This package is intended for personal use.

## Features

| Popover | Dialog |
| --- | --- |
| <video src="https://github.com/user-attachments/assets/3cfc601d-8b5e-4ddc-bba6-7173b6edd70b" width="400"> | <video src="https://github.com/user-attachments/assets/954341be-e6ce-4611-9ef4-48f31ba9410c" width="400">  |

## Usage

### UIKit

```swift
// 1. Initialize a MonoMenuProtocol model

// Popover
let monoPopover = MonoPopover(sourceView: button)

// Dialog
let monoDialog = MonoDialog()

// 2. Configure the menu
monoPopover.dimmingBackground = true

// 3. Assign it to your presented view controller's monoMenu property
presentedViewController.monoMenu = monoPopover // or monoDialog

// 4. Present it
present(menuVC, animated: true)
```

Or you can setup quickly

```swift
presentedViewController.monoMenu = .popover(sourceView: button) // or .dialog
```

## Requirements

- iOS 13.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/lumisilk/MonoMenu.git", from: "0.1.0")
]
```

Or add it directly through Xcode:
1.	Go to File > Add Package Dependencies
2.	Search for: https://github.com/lumisilk/MonoMenu.git
3.	Add the package to your project.

## License

MonoMenu is available under the MIT license.
