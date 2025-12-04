//
//  WindowCloser.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 13/11/25.
//


import SwiftUI
import AppKit

struct WindowCloser: View {
    var body: some View {
        RepresentableWrapper()
            .frame(width: 0, height: 0) // keep it invisible
            .allowsHitTesting(false)
    }

    // Platform-specific representable that actually closes the window
    private struct RepresentableWrapper: View {
        var body: some View {
            MacWindowCloser()
        }
    }

    private struct MacWindowCloser: NSViewRepresentable {
        func makeNSView(context: Context) -> NSView {
            let view = NSView()
            // Defer so SwiftUI can finish the openWindow operation.
            DispatchQueue.main.async {
                view.window?.close()
            }
            return view
        }
        func updateNSView(_ nsView: NSView, context: Context) {}
    }
}
