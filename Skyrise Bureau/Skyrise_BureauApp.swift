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
    /// This is for reseting the SwiftData variable
    let resetUserData: Bool = false
    
    /// For the usage of test data
    let useTestData: Bool = false
    
    /// For the usage of test data with flying planes
    let useTestDataWithFlyingPlanes: Bool = false
    
    /// ENSURE ALL VARIABLES ABOVE ARE SET TO false BEFORE FINAL
    /// BUILD OF APP
    var body: some Scene {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserData.self
            ])
            let config = ModelConfiguration()
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        WindowGroup("Welcome to Skyrise Bureau!", id: "welcome") {
            WelcomeView(debug: resetUserData)
        }
        .modelContainer(sharedModelContainer)
        WindowGroup("Skyrise Bureau", id: "main") {
            ContentView(resetUserData: resetUserData, useTestData: useTestData, useTestDataWithFlyingPlanes: useTestDataWithFlyingPlanes)
        }
        .modelContainer(sharedModelContainer)
    }
}
