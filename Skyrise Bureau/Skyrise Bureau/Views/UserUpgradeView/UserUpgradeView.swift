//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import SwiftData

extension View {
    @ViewBuilder
    func adaptiveProminentButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self.buttonStyle(.borderedProminent)
        }
    }
}

extension View {
    @ViewBuilder
    func adaptiveButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(.bordered)
        }
    }
}

struct UserUpgradeView: View {
    @State var showAirportPickerView: Bool = true
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
    @Environment(\.modelContext) var modelContext
    @Binding var userData: UserData
    @Environment(\.dismiss) var dismiss
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
    
    @State var screen: Int = 1
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            if !showAirportPickerView {
                AirportPickerView(airportSelected: $selectedAirport, userData: userData, finishedPickingScreen: $showAirportPickerView)
                    .transition(.move(edge: .leading))
                    .padding()
            } else {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                TextField(userData.airlineName, text: $userData.airlineName)
                                    .textFieldStyle(.plain)
                                    .font(.largeTitle)
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                Text("As managed by ".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                TextField(userData.name, text: $userData.name)
                                    .textFieldStyle(.plain)
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            HStack {
                                Text("ACTIVE RESERVES: $\(userData.accountBalance.withCommas)".uppercased())
                                    .font(.caption2)
                                    .fontWidth(.expanded)
                                    .contentTransition(.numericText(countsDown: true))
                                Spacer()
                            }
                        }
                        Text("\(userData.xpPoints)")
                            .fontWidth(.expanded)
                            .font(.largeTitle)
                        Text("AVAILABLE\nXP POINTS")
                            .fontWidth(.expanded)
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .padding()
                        }
                        .adaptiveButtonStyle()
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
                        .adaptiveProminentButtonStyle()
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
                        .adaptiveProminentButtonStyle()
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
                        .adaptiveProminentButtonStyle()
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
        .onChange(of: showAirportPickerView) { oldValue, newValue in
            if !oldValue && newValue && AirportDatabase.shared.allAirports.contains(where: {selectedAirport.name == $0.name}) {
                withAnimation {
                    userData.deliveryHubs.append(selectedAirport)
                    userData.accountBalance -= 10000000
                }
                selectedAirport = Airport(
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
            }
        }
    }
}

#Preview {
    UserUpgradeView(userData: .constant(testUserDataEndgame))
}
