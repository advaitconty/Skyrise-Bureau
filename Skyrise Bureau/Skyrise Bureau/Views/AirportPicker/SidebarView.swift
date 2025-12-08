//
//  SidebarView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI

extension AirportPickerView {
    func sidebarView(height: CGFloat) -> some View {
        VStack {
            ScrollView {
                ForEach(filteredAirports, id: \.uniqueID) { airport in
                    if airport == airportSelected {
                        Button {
                            withAnimation {
                                airportSelected = airport
                            }
                        } label: {
                            VStack {
                                HStack {
                                    Text(airport.name)
                                        .font(.title)
                                        .fontWidth(.expanded)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(airport.iata) (\(airport.icao))")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text(airport.region.rawValue)
                                        .fontWidth(.condensed)
                                }
                                HStack {
                                    Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("Elevation: \(airport.elevation)m")
                                        .fontWidth(.condensed)
                                }
                            }
                            .padding()
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button {
                            withAnimation {
                                airportSelected = airport
                            }
                        } label: {
                            VStack {
                                HStack {
                                    Text(airport.name)
                                        .font(.title)
                                        .fontWidth(.expanded)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(airport.iata) (\(airport.icao))")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text(airport.region.rawValue)
                                        .fontWidth(.condensed)
                                }
                                HStack {
                                    Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("Elevation: \(airport.elevation)m")
                                        .fontWidth(.condensed)
                                }
                            }
                            .padding()
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
        .frame(width: CGFloat(300), height: height - 30)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}
