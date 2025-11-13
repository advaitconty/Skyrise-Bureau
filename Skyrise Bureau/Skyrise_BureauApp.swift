//
//  Skyrise_BureauApp.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData

@main
struct Skyrise_BureauApp: App {
    var body: some Scene {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserData.self
            ])
            let config = ModelConfiguration()
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        WindowGroup("Welcome to Skyrise Bureau!", id: "welcome") {
            WelcomeView()
        }
        .modelContainer(sharedModelContainer)
        WindowGroup("Skyrise Bureau", id: "main") {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
