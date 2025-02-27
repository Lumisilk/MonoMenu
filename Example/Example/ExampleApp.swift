//
//  ExampleApp.swift
//  Example
//
//  Created by lumisilk on 2025/02/19.
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ViewControllerAdapter {
                    UINavigationController(rootViewController: UIKitExample())
                }
                .ignoresSafeArea()
                .tabItem {
                    Label("UIKit", systemImage: "square.and.pencil")
                }
            }
        }
    }
}
