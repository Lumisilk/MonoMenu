//
//  ViewControllerAdapter.swift
//  Example
//
//  Created by lumisilk on 2025/02/19.
//


import SwiftUI

struct ViewControllerAdapter<V: UIViewController>: UIViewControllerRepresentable {
    let make: () -> V
    
    func makeUIViewController(context: Context) -> V {
        make()
    }
    
    func updateUIViewController(_ uiViewController: V, context: Context) {
    }
}
