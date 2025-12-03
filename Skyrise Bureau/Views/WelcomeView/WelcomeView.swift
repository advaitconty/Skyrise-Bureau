//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 11/11/25.
//

import SwiftUI
import SwiftData

struct WelcomeView: View {
    @State var showLogo: Bool = true
    @State var showBody: Bool = false
    @State var error: Bool = false
    @State var errorText: String = ""
    @Environment(\.openWindow) var openWindow
    @State var viewPage: Int = 1
    @Environment(\.colorScheme) var colorScheme
    @State var carousellItem: Int = 1
    @State var userDataForAddition: UserData = UserData(name: "", airlineName: "", airlineIataCode: "", planes: [], xp: 0, levels: 1, airlineReputation: 0.6, reliabilityIndex: 0.7, fuelDiscountMultiplier: 1, lastFuelPrice: 0.75, pilots: 3, flightAttendents: 3, maintainanceCrew: 3, currentlyHoldingFuel: 1_000_000, maxFuelHoldable: 4_000_000, weeklyPilotSalary: 400, weeklyFlightAttendentSalary: 300, weeklyFlightMaintainanceCrewSalary: 250, pilotHappiness: 0.95, flightAttendentHappiness: 0.95, maintainanceCrewHappiness: 0.95, campaignRunning: false, deliveryHubs: [], accountBalance: 0)
    @State var fleetChoice: Int = 0
    @State var selectedHomeBase: Airport = Airport(
        name: "Dubai International Airport",
        city: "Dubai",
        country: "United Arab Emirates",
        iata: "DXB",
        icao: "OMDB",
        region: .asia,
        latitude: 25.2532,
        longitude: 55.3657,
        runwayLength: 4000,
        elevation: 19,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.78, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 4800, gatesAvailable: 120, slotEfficiency: 0.94)
    )
    @State var airlineHomeBase: Airport = Airport(
        name: "Los Angeles International Airport",
        city: "Los Angeles",
        country: "United States",
        iata: "LAX",
        icao: "KLAX",
        region: .northAmerica,
        latitude: 33.9416,
        longitude: -118.4085,
        runwayLength: 3939,
        elevation: 38,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.72, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4500, gatesAvailable: 130, slotEfficiency: 0.92)
    )
    @Query var originalUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    @State var showNextForAirport: Bool = false
    var debug: Bool
    ///For debugging
    ///If above value is true, modelcontext will be cleared at start
    ///Now controlled from the main App Definition
    @State var closeWindow: Bool = false
        
    var body: some View {
        VStack {
            if viewPage == 1 {
                pageOneView()
            } else if viewPage == 2 {
                AirportPickerView(maxRange: 0, startAirport: nil, moveOn: Binding(get: {viewPage == 2}, set: { if $0 == true { withAnimation(completionCriteria: .removed) { viewPage = 3 } completion: { print("Completed") } } else { withAnimation { viewPage = 2 } } }), finalAirportSelected: $selectedHomeBase, userData: userDataForAddition)
            } else if viewPage == 3 {
                pageThreeView()
                    .onAppear {
                        userDataForAddition.deliveryHubs.append(selectedHomeBase)
                    }
            }
        }
        .padding()
        .frame(minWidth: 700, minHeight: 400)
        .onAppear {
            if debug {
                for item in originalUserData {
                    print(item)
                    modelContext.delete(item)
                }
                try? modelContext.save()
            } else {
                if originalUserData.count >= 1 {
                    modelContext.insert(userDataForAddition)
                    try? modelContext.save()
                    openWindow(id: "main")
                    closeWindow = true
                }
            }
        }
        .background(AnyView(closeWindow ? WindowCloser() : nil))
    }
}
