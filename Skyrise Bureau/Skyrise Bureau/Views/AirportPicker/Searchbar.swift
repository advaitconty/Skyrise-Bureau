//
//  Searchbar.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI

extension AirportPickerView {
    func searchbar() -> some View {
        VStack {
            if #available(iOS 26.0, *) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Some airport name...", text: $searchTerm)
                        .fontWidth(.condensed)
                }
                .padding()
                .glassEffect()
                
            } else {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Some airport name...", text: $searchTerm)
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            }
        }
    }
}
