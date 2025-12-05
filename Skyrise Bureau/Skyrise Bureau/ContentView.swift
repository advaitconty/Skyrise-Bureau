//
//  ContentView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData
import Foundation
import Combine

struct ContentView: View {
    @State var showWelcome: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    let resetUserData: Bool
    let useTestData: DataTypeToUse
    
    var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

#Preview {
    ContentView(resetUserData: false, useTestData: .endGame)
}
