//
//  Skyrise_BureauApp.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI

@main
struct Skyrise_BureauApp: App {
    var body: some Scene {
        WindowGroup {

            AirportPickerView()
                .padding()
                .frame(minWidth: 700, minHeight: 400)
        }
    }
}
