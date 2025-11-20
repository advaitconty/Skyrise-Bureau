//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

struct UserUpgradeView: View {
    @Binding var userData: UserData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
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
                    Spacer()
                }
            }
            ScrollView {
                // MARK: Paychecks
                HStack {
                    Text("PAYCHECKS")
                        .font(.title3)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    salaryViewItem()
                }
                
                // MARK: Airline Stats
                HStack {
                    Text("AIRLINE INFO")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                // Hub airports
                VStack {
                    HStack {
                        Text("\(userData.deliveryHubs.count) Hub airports owned".uppercased())
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(userData.deliveryHubs, id: \.uniqueID) { airport in
                                VStack {
                                    Text("\(countryNameToEmoji(airport.country))\(airport.iata) (\(airport.icao))\n")
                                        .fontWidth(.expanded)
                                    +
                                    Text(airport.name)
                                        .fontWidth(.condensed)
                                }
                                .padding(5)
                                .frame(width: 150, height: 100)
                                .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            Button {
                                
                            } label: {
                                VStack {
                                    Text("New hub airport")
                                        .fontWidth(.expanded)
                                    Image(systemName: "plus")
                                        .font(.system(size: 24))
                                        .padding(1)
                                    Text("$10,000,000")
                                        .fontWidth(.condensed)
                                }
                                .padding(5)
                                .frame(width: 150, height: 100)
                                .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                // Planes
                VStack {
                    HStack {
                        Text("\(userData.planes.count) Airplanes owned".uppercased())
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach($userData.planes, id: \.id) { $plane in
                                VStack {
                                    Image(plane.aircraftID)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 5.0))

                                    TextField(plane.aircraftname, text: $plane.aircraftname)
                                        .textFieldStyle(.plain)
                                        .font(.subheadline)
                                        .fontWidth(.expanded)
                                    HStack {
                                        Text(plane.aircraftID)
                                            .font(.caption)
                                            .fontWidth(.condensed)
                                        TextField(plane.registration, text: $plane.registration)
                                            .textFieldStyle(.plain)
                                            .font(.caption)
                                            .fontWidth(.condensed)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    Text("\(Int(plane.hoursFlown).withCommas)h flown - \(plane.isAirborne ? "currently flying" : "at \(plane.currentAirportLocation!.iata)")")
                                        .font(.caption)
                                        .fontWidth(.condensed)
                                }
                                .padding(5)
                                .frame(width: 150, height: 160)
                                .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    UserUpgradeView(userData: .constant(testUserDataEndgame))
}
