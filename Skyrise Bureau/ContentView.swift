//
//  ContentView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var moidifiableUserdata: UserData = testUserData
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    
    var body: some View {
        VStack {
            MapView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
