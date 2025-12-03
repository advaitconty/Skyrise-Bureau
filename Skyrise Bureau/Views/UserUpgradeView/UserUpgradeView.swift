//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import SwiftData

struct UserUpgradeView: View {
    @State var showAirportPickerView: Bool = false
    @State var selectedAirport: Airport = Airport(
        name: "Soote",
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
    @Query var swiftDataUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            return swiftDataUserData.first ?? testUserData
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
    /// Debug stuff
    /// Keep in case above binding decides to cause problems again
    /// stupid bindings
    //    var userData: Binding<UserData> {
    //        Binding {
    //            return testUserData
    //        } set: { value in
    //            testUserData = value
    //        }
    //    }
    
    @State var screen: Int = 3
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            if showAirportPickerView {
                AirportPickerView(airportText: "Please select your new hub airport", maxRange: 0, startAirport: nil, moveOn: $showAirportPickerView, finalAirportSelected: $selectedAirport, disallowedAirports: userData.wrappedValue.deliveryHubs, userData: userData.wrappedValue)
                    .transition(.move(edge: .leading))
                    .padding()
            } else {
                VStack {
                    HStack {
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
                                    .contentTransition(.numericText(countsDown: true))
                                Spacer()
                            }
                        }
                        Text("\(userData.wrappedValue.xpPoints)")
                            .fontWidth(.expanded)
                            .font(.largeTitle)
                        Text("AVAILABLE\nXP POINTS")
                            .fontWidth(.expanded)
                    }
                    HStack {
                        Button {
                            withAnimation(.smooth, completionCriteria: .removed) {
                                screen = 1
                            } completion: {
                                print("Screen changed")
                            }
                        } label: {
                            Spacer()
                            Text("SALARY AND HUBS")
                                .fontWidth(.expanded)
                                .font(.caption)
                            Spacer()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(screen == 1 ? .accentColor : .gray)
                        
                        
                        Button {
                            withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                screen = 2
                            } completion: {
                                print("Screen changed")
                            }
                        } label: {
                            Spacer()
                            Text("REPUTATION")
                                .fontWidth(.expanded)
                                .font(.caption)
                            Spacer()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(screen == 2 ? .accentColor : .gray)
                        
                        Button {
                            withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                                screen = 3
                            } completion: {
                                print("Screen changed")
                            }
                        } label: {
                            Spacer()
                            Text("UPGRADES")
                                .fontWidth(.expanded)
                                .font(.caption)
                            Spacer()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(screen == 3 ? .accentColor : .gray)
                    }
                    if screen == 1 {
                        ScrollView {
                            /// This is gonna be a v2 feature, will be a non-issue
                            paycheckView()
                            
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
                        .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    } else if screen == 2 {
                        reputationView()
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    } else if screen == 3 {
                        upgradeView()
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    }
                }
                .padding()
                .transition(.move(edge: .leading))
            }
        }
        .frame(width: 600, height: 400)
    }
}

#Preview {
    UserUpgradeView()
}
