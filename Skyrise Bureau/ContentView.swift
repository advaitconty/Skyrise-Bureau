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
            MapView(userData: $moidifiableUserdata)
        }
        .onAppear {
            if let item = userData.first {
                moidifiableUserdata = item
            }
        }
    }
}

#Preview {
    ContentView()
}
