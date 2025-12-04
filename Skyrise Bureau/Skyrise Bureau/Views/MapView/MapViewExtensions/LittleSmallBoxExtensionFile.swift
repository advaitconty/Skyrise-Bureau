//
//  LittleSmallBoxExtensionFile.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension MapView {
    // MARK: Little small box thingy
    func littleSmallBoxThingy(icon: String, item: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(item)
                .fontWidth(.condensed)
        }
        .padding(5)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
    func editableLittleSmallBoxThingy(icon: String, item: Binding<Double>, placeholder: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text("$")
                .fontWidth(.condensed)
            TextField(placeholder, value: item, format: .currency(code: "USD"))
                .fontWidth(.condensed)
                .textFieldStyle(.roundedBorder)
        }
        .padding(5)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
}

extension MapView {
    // MARK: Little small box textfield
    func littleSmallBoxField(icon: String, item: Binding<Double>) -> some View {
        HStack {
            Image(systemName: icon)
            TextField(String(item.wrappedValue), value: item, format: .currency(code: "USD"))
                .fontWidth(.condensed)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
        }
        .padding(5)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
}
