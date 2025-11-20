//
//  Configurator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension AirplaneStoreView {
    func configuator(plane: Aircraft) -> some View {
        ScrollView {
            HStack {
                Text("Purchase Options")
                    .fontWidth(.expanded)
                Spacer()
            }
            
            // Seating
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "carseat.right")
                    Text("Economy class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.economy)", value: $preferedSeatingConfig.economy, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.economy) {
                            doSeatingChecks(plane)
                        }
                    Stepper("", value: $preferedSeatingConfig.economy)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "star")
                    Text("Premium economy class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.premiumEconomy)", value: $preferedSeatingConfig.premiumEconomy, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.premiumEconomy) {
                            doSeatingChecks(plane)
                        }
                    Stepper("", value: $preferedSeatingConfig.premiumEconomy)
                    Spacer()
                }
                
                
                HStack {
                    Spacer()
                    Image(systemName: "briefcase")
                    Text("Business class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.business)", value: $preferedSeatingConfig.business, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.business) {
                            doSeatingChecks(plane)
                        }
                    Stepper("", value: $preferedSeatingConfig.business)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "crown")
                    Text("First class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.first)", value: $preferedSeatingConfig.first, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.first) {
                            doSeatingChecks(plane)
                        }
                    Stepper("", value: $preferedSeatingConfig.first)
                    Spacer()
                }
                
                if showNotAllSeatsFilled {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("WARNING")
                                .fontWidth(.expanded)
                                
                        }
                        Text("Not all seats have been filled. There are \(String(format: "%.1f", Double(plane.maxSeats) - preferedSeatingConfig.seatsUsed)) worth of economy seats that you can fill up.")
                            .fontWidth(.condensed)
                    }
                    .transition(.blurReplace)
                }
                
                if showAllSeatsFileld {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("ERROR")
                                .fontWidth(.expanded)
                        }
                        Text("All seats have been filled up. Please remove \(String(format: "%.1f", abs(Double(plane.maxSeats) - preferedSeatingConfig.seatsUsed))) worth of economy seats to purchase this plane.")
                            .fontWidth(.condensed)
                    }
                    .transition(.blurReplace)
                }
                
                if showAllSeatsFileld || showNotAllSeatsFilled {
                    Button {
                        showContextScreen = true
                    } label: {
                        Image(systemName: "questionmark")
                    }
                    .popover(isPresented: $showContextScreen, arrowEdge: .bottom) {
                        explainationOnConfigurator()
                            .frame(maxWidth: 600, maxHeight: 600)
                    }
                }
            }
            
            // Miscellanous
            VStack {
                HStack {
                    Text("Registration")
                        .fontWidth(.condensed)
                    TextField("SK-YBR", text: $registration)
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack {
                    Text("Aircraft name")
                        .fontWidth(.condensed)
                    TextField("City of Birmingham...", text: $aircraftName)
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
            }
            
            availableAirportPicker()
            
            Button {
                
            } label: {
                Text("Purchase jet for $\(Int(plane.purchasePrice))")
                    .fontWidth(.condensed)
            }
        }
        .padding(8)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

}
