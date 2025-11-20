//
//  Skyrise_BureauApp.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData
import Foundation

/// Enum to decide what data type to use
enum DataTypeToUse: Codable {
    case regular, flyingPlanes, endGame, none
}

@main
struct Skyrise_BureauApp: App {
    /// This is for reseting the SwiftData variable
    let resetUserData: Bool = false
    
    /// For the usage of any test data
    let useTestData: DataTypeToUse = .endGame
    
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
            ContentView(resetUserData: resetUserData, useTestData: useTestData)
        }
        .modelContainer(sharedModelContainer)
        WindowGroup("Jet Set Emporium", id: "shop") {
            AirplaneStoreView()
        }
        .modelContainer(sharedModelContainer)
    }
}
