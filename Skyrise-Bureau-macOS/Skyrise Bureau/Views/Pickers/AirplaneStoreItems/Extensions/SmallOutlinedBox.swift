//
//  SmallOutlinedBox.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import Foundation
import SwiftUI

extension AirplaneStoreView {
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
}
