//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import SwiftData

struct UserUpgradeView: View {
    @Query var swiftDataUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            swiftDataUserData.first ?? testUserData
        } set: { value in
            if let item = swiftDataUserData.first {
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

    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField(userData.wrappedValue.airlineName, text: userData.airlineName)
                        .textFieldStyle(.plain)
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text("As managed by ".uppercased())
                        .font(.caption2)
                        .fontWidth(.expanded)
                    TextField(userData.wrappedValue.name, text: userData.name)
                        .textFieldStyle(.plain)
                        .font(.caption2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Text("ACTIVE RESERVES: $\(userData.wrappedValue.accountBalance.withCommas)".uppercased())
                        .font(.caption2)
                        .fontWidth(.expanded)
                    Spacer()
                }
            }
            ScrollView {
                /// This is gonna be a v2 feature, will be a non-issue
//                paycheckView()
                
                // MARK: Airline Stats Start
                HStack {
                    Text("AIRLINE INFO")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                // Hub airports
                hubAirportsView()
                
                // Planes
                planeStatsViewForUpgrades()
            }
        }
        .padding()
    }
}

#Preview {
    UserUpgradeView()
}
