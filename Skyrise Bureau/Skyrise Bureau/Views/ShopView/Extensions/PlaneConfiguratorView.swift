//
//  PlaneConfiguratorView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI

extension ShopView {
    func planeConfiguratorView(_ plane: Aircraft) -> some View {
        ScrollView {
            VStack {
                Image(plane.modelCode)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                VStack {
                    HStack {
                        Text(plane.name)
                            .font(.system(size: 36))
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    HStack {
                        Text(plane.description)
                            .font(.system(size: 16))
                            .fontWidth(.condensed)
                        Spacer()
                    }
                }
                
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 150), spacing: 12)
                ], spacing: 12) {
                    littleSmallBoxThingyForMainView(icon: "ruler", item: "\(plane.maxRange)km")
                    littleSmallBoxThingyForMainView(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                    littleSmallBoxThingyForMainView(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
                    littleSmallBoxThingyForMainView(icon: "fuelpump", item: "\(plane.fuelBurnRate)L/km")
                    littleSmallBoxThingyForMainView(icon: "road.lanes", item: "\(plane.minRunwayLength)m")
                    littleSmallBoxThingyForMainView(icon: "dollarsign.circle", item: "$\(plane.maintenanceCostPerHour)/km")
                }
                VStack {
                    HStack {
                        Text("Normal seating arrangement")
                            .fontWidth(.condensed)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "carseat.right")
                            .font(.system(size: 12))
                        Text("\(plane.defaultSeating.economy)")
                            .font(.system(size: 12))
                            .fontWidth(.condensed)
                        Divider()
                        Image(systemName: "star")
                            .font(.system(size: 12))
                        Text("\(plane.defaultSeating.premiumEconomy)")
                            .font(.system(size: 12))
                            .fontWidth(.condensed)
                        Divider()
                        Image(systemName: "briefcase")
                            .font(.system(size: 12))
                        Text("\(plane.defaultSeating.business)")
                            .font(.system(size: 12))
                            .fontWidth(.condensed)
                        Divider()
                        Image(systemName: "crown")
                            .font(.system(size: 12))
                        Text("\(plane.defaultSeating.first)")
                            .font(.system(size: 12))
                            .fontWidth(.condensed)
                    }
                }
                .frame(maxWidth: 250, maxHeight: 50)
                .padding()
                .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                
                if userData.accountBalance > plane.purchasePrice {
                    seatingConfiguration()
                    .onAppear {
                            preferedSeatingConfig = plane.defaultSeating
                        }
                    
                    
                    if !showAllSeatsFilled {
                        if showNotAllSeatsFullWarning {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .symbolRenderingMode(.multicolor)
                                
                                Text("Not all seats are full on this plane. You can fit up to \(-1 * Int(preferedSeatingConfig.seatsUsed) + selectedPlane!.maxSeats) more economy seats on this jet.")
                                    .fontWidth(.condensed)
                            }
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                userData.planes.append(FleetItem(aircraftID: plane.modelCode, aircraftname: aircraftName, registration: registration, hoursFlown: 0, seatingLayout: preferedSeatingConfig, kilometersTravelledSinceLastMaintainence: 0))
                                userData.maintainanceCrew += 3
                                userData.pilots += plane.pilots
                                userData.flightAttendents += plane.flightAttendents
                                dismiss()
                            } label: {
                                Text("Purchase for $\(plane.purchasePrice.withCommas)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        } else {
                            Button {
                                userData.planes.append(FleetItem(aircraftID: plane.modelCode, aircraftname: aircraftName, registration: registration, hoursFlown: 0, seatingLayout: preferedSeatingConfig, kilometersTravelledSinceLastMaintainence: 0))
                                userData.maintainanceCrew += 3
                                userData.pilots += plane.pilots
                                userData.flightAttendents += plane.flightAttendents
                                dismiss()
                            } label: {
                                Text("Purchase for $\(plane.purchasePrice.withCommas)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .hoverEffect()
                        }
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("Your ideal seating config fair outweighs what this plane can carry. Please try something else.")
                                .fontWidth(.condensed)
                        }
                    }
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("You do not have enough funds to purchase this plane")
                            .fontWidth(.condensed)
                    }
                }
            }
        }
    }
}
