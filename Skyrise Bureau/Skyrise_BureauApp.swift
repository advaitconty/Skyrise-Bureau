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
    
    @Environment(\.openWindow) var openWindow
    
    var body: some Scene {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserData.self
            ])
            let config = ModelConfiguration()
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        Window("Welcome to Skyrise Bureau!", id: "welcome") {
            WelcomeView(debug: resetUserData)
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)

        Window("Skyrise Bureau", id: "main") {
            ContentView(resetUserData: resetUserData, useTestData: useTestData)
        }
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }

        Window("Jet Set Emporium", id: "shop") {
            AirplaneStoreView()
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }

        Window("About Your Airline", id: "attributes") {
            UserUpgradeView()
//            Text("stupid shit just work")
        }
        .modelContainer(sharedModelContainer)
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }

        Window("KEROX", id: "fuel") {
            FuelPriceView()
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }
        
        Window("About Skyrise Bureau", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
        .windowResizability(.contentSize)
    }
}
