//
//  ContentView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var moidifiableUserdata: Binding<UserData> {
        Binding {
            userData.first ?? testUserData
        } set: { value in
            if let item = userData.first {
                item.planes = value.planes
                item.deliveryHubs = value.deliveryHubs
                item.airlineIataCode = value.airlineIataCode
                item.airlineName = value.airlineName
                item.name = value.name
                item.accountBalance = value.accountBalance
                item.airlineReputation = value.airlineReputation
                item.campaignEffectiveness = value.campaignEffectiveness
                item.campaignRunning = value.campaignRunning
                item.currentlyHoldingFuel = value.currentlyHoldingFuel
                item.flightAttendentHappiness = value.flightAttendentHappiness
                item.flightAttendents = value.flightAttendents
                item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                item.lastFuelPrice = value.lastFuelPrice
                item.levels = value.levels
                item.maintainanceCrew = value.maintainanceCrew
                item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                item.maxFuelHoldable = value.maxFuelHoldable
                item.pilotHappiness = value.pilotHappiness
                item.pilots = value.pilots
                item.pilotHappiness = value.pilotHappiness
                item.xp = value.xp
                
                try? modelContext.save()
            }
        }
    }
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    var resetUserData: Bool
    var useTestData: DataTypeToUse
    var body: some View {
        VStack {
            MapView(userData: moidifiableUserdata)
                .onAppear {
                    /// Test stubs
                    if resetUserData {
                        for item in userData {
                            modelContext.delete(item)
                        }
                        try? modelContext.save()
                    } else if useTestData != .none {
                        var value: UserData
                        if useTestData == .flyingPlanes {
                            value = testUserDataWithFlyingPlanes
                            print("Flying planes test data used")
                        } else if useTestData == .regular {
                            value = testUserData
                            print("Regular test data used")
                        } else {
                            value = testUserDataEndgame
                            print("Endgame test user data being used")
                        }
                        if let item = userData.first {
                            item.planes = value.planes
                            item.deliveryHubs = value.deliveryHubs
                            item.airlineIataCode = value.airlineIataCode
                            item.airlineName = value.airlineName
                            item.name = value.name
                            item.accountBalance = value.accountBalance
                            item.airlineReputation = value.airlineReputation
                            item.campaignEffectiveness = value.campaignEffectiveness
                            item.campaignRunning = value.campaignRunning
                            item.currentlyHoldingFuel = value.currentlyHoldingFuel
                            item.flightAttendentHappiness = value.flightAttendentHappiness
                            item.flightAttendents = value.flightAttendents
                            item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                            item.lastFuelPrice = value.lastFuelPrice
                            item.levels = value.levels
                            item.maintainanceCrew = value.maintainanceCrew
                            item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                            item.maxFuelHoldable = value.maxFuelHoldable
                            item.pilotHappiness = value.pilotHappiness
                            item.pilots = value.pilots
                            item.pilotHappiness = value.pilotHappiness
                            item.xp = value.xp
                            
                            try? modelContext.save()
                        }
                    }
                    
                    
                }
        }
    }
}

#Preview {
    ContentView(resetUserData: false, useTestData: .endGame)
}
