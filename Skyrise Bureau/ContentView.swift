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
        .onChange(of: moidifiableUserdata) {
            if let item = userData.first {
                item.planes = moidifiableUserdata.planes
                item.deliveryHubs = moidifiableUserdata.deliveryHubs
                item.airlineIataCode = moidifiableUserdata.airlineIataCode
                item.airlineName = moidifiableUserdata.airlineName
                item.name = moidifiableUserdata.name
                item.accountBalance = moidifiableUserdata.accountBalance
                item.airlineReputation = moidifiableUserdata.airlineReputation
                item.campaignEffectiveness = moidifiableUserdata.campaignEffectiveness
                item.campaignRunning = moidifiableUserdata.campaignRunning
                item.currentlyHoldingFuel = moidifiableUserdata.currentlyHoldingFuel
                item.flightAttendentHappiness = moidifiableUserdata.flightAttendentHappiness
                item.flightAttendents = moidifiableUserdata.flightAttendents
                item.fuelDiscountMultiplier = moidifiableUserdata.fuelDiscountMultiplier
                item.lastFuelPrice = moidifiableUserdata.lastFuelPrice
                item.levels = moidifiableUserdata.levels
                item.maintainanceCrew = moidifiableUserdata.maintainanceCrew
                item.maintainanceCrewHappiness = moidifiableUserdata.maintainanceCrewHappiness
                item.maxFuelHoldable = moidifiableUserdata.maxFuelHoldable
                item.pilotHappiness = moidifiableUserdata.pilotHappiness
                item.pilots = moidifiableUserdata.pilots
                item.pilotHappiness = moidifiableUserdata.pilotHappiness
                item.xp = moidifiableUserdata.xp
                
                try? modelContext.save()
            }
        }
    }
}

#Preview {
    ContentView()
}
