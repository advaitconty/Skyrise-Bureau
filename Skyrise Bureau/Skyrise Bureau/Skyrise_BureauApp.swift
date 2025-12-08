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
    let useTestData: DataTypeToUse = .none
    
    /// ENSURE ALL VARIABLES ABOVE ARE SET TO false BEFORE FINAL
    /// BUILD OF APP
        
    var body: some Scene {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserData.self,
            ])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        WindowGroup() {
            ContentView(resetUserData: resetUserData, useTestData: useTestData)
        }
        .modelContainer(sharedModelContainer)
    }
}
