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
    func editableLittleSmallBoxThingy(icon: String, item: Binding<Int>, placeholder: String) -> some View {
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
