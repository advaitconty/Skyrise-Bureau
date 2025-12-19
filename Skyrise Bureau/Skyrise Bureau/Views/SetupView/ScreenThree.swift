//
//  ScreenThree.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI

extension SetupView {
    func thirdScreen() -> some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "backpack")
                    Text("Select your starter pack")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                    if fleetChoice != 0 {
                        if #available(iOS 26.0, *) {
                            Button {
                                if fleetChoice == 1 {
                                    // CRJ 900
                                    userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Puddle Jumper", registration: "N-SMOL1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Flying Pencil", registration: "N-TINY2", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    // E175-E2
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Middle Management", registration: "N-RGNL1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Commuter Special", registration: "N-REG01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.pilots = 2 + 2 + 2 + 2 // 2 for each CRJ900, 2 for each E175-E2
                                    userData.flightAttendents = 2 + 2 + 2 + 2 // 2 for each CRJ900, 2 for each E175-E2
                                    userData.accountBalance = 32500000
                                } else if fleetChoice == 2 {
                                    // Boeing 737-800 (New Generation)
                                    userData.planes.append(FleetItem(aircraftID: "B737-800NG", aircraftname: "Good Ol' Reliable", registration: "N-MERICA", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 138, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    // E175-E2
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Ranch Hand", registration: "N-YEEHAW", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Stars and Stripes", registration: "N-EAGLE1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.pilots = 2 + 2 + 2 // 2 for each B737-800NG, 2 for each E175-E2
                                    userData.flightAttendents = 4 + 2 + 2 // 4 for each B737-800NG, 2 for each E175-E2
                                    userData.accountBalance = 31000000
                                } else if fleetChoice == 3 {
                                    // Airbus A319
                                    userData.planes.append(FleetItem(aircraftID: "A319", aircraftname: "Le Continental", registration: "N-FANCY1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 114, premiumEconomy: 16, business: 8, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    // CRJ900
                                    userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "Tea and Crumpets", registration: "N-POSH01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Sophisticate", registration: "N-CLASSY", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.pilots = 2 + 2 + 2 // 2 for each A319, 2 for each CRJ900
                                    userData.flightAttendents = 4 + 2 + 2 // 4 for each A319, 2 for each CRJ900
                                    userData.accountBalance = 30500000
                                } else if fleetChoice == 4 {
                                    // Airbus A320
                                    userData.planes.append(FleetItem(aircraftID: "A320", aircraftname: "Bread and Butter", registration: "N-BASIC1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 132, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    // Boeing 737-800 (New Generation)
                                    userData.planes.append(FleetItem(aircraftID: "B737-800NG", aircraftname: "The Minivan", registration: "N-SAFE1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 138, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.pilots = 2 + 2  // 2 for each A320, 2 for each B737-800NG
                                    userData.flightAttendents = 4 + 2 // 4 for each A320, 2 for each B737-800NG
                                    userData.accountBalance = 30500000
                                } else if fleetChoice == 5 {
                                    // E175-E2
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Fresh Off The Lot", registration: "N-NEWB01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Dawn of the Millenium", registration: "N-TECH01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    // E190-E2
                                    userData.planes.append(FleetItem(aircraftID: "E190E2", aircraftname: "Actually has WiFi", registration: "N-FANCY2", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 88, premiumEconomy: 12, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                    userData.pilots = 2 + 2 + 2 // 2 for each E175-E2, 2 for each E190-E2
                                    userData.flightAttendents = 2 + 2 + 3 // 2 for each E175-E2, 2 for each E190-E2
                                    userData.accountBalance = 34000000
                                }
                                
                                /// For the stupid maintainance crew that I can't be bothered to add manually
                                /// Will do 3 for each jet, based on planes added
                                userData.maintainanceCrew = userData.planes.count * 3
                                
                                dismiss()
                            } label: {
                                Image(systemName: "checkmark")
                                Text("Finish setup!")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        } else {
                            
                                Button {
                                    if fleetChoice == 1 {
                                        // CRJ 900
                                        userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Puddle Jumper", registration: "N-SMOL1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Flying Pencil", registration: "N-TINY2", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        // E175-E2
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Middle Management", registration: "N-RGNL1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Commuter Special", registration: "N-REG01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.pilots = 2 + 2 + 2 + 2 // 2 for each CRJ900, 2 for each E175-E2
                                        userData.flightAttendents = 2 + 2 + 2 + 2 // 2 for each CRJ900, 2 for each E175-E2
                                        userData.accountBalance = 32500000
                                    } else if fleetChoice == 2 {
                                        // Boeing 737-800 (New Generation)
                                        userData.planes.append(FleetItem(aircraftID: "B737-800NG", aircraftname: "Good Ol' Reliable", registration: "N-MERICA", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 138, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        // E175-E2
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Ranch Hand", registration: "N-YEEHAW", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Stars and Stripes", registration: "N-EAGLE1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.pilots = 2 + 2 + 2 // 2 for each B737-800NG, 2 for each E175-E2
                                        userData.flightAttendents = 4 + 2 + 2 // 4 for each B737-800NG, 2 for each E175-E2
                                        userData.accountBalance = 31000000
                                    } else if fleetChoice == 3 {
                                        // Airbus A319
                                        userData.planes.append(FleetItem(aircraftID: "A319", aircraftname: "Le Continental", registration: "N-FANCY1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 114, premiumEconomy: 16, business: 8, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        // CRJ900
                                        userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "Tea and Crumpets", registration: "N-POSH01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.planes.append(FleetItem(aircraftID: "CRJ900", aircraftname: "The Sophisticate", registration: "N-CLASSY", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 10, business: 5, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.pilots = 2 + 2 + 2 // 2 for each A319, 2 for each CRJ900
                                        userData.flightAttendents = 4 + 2 + 2 // 4 for each A319, 2 for each CRJ900
                                        userData.accountBalance = 30500000
                                    } else if fleetChoice == 4 {
                                        // Airbus A320
                                        userData.planes.append(FleetItem(aircraftID: "A320", aircraftname: "Bread and Butter", registration: "N-BASIC1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 132, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        // Boeing 737-800 (New Generation)
                                        userData.planes.append(FleetItem(aircraftID: "B737-800NG", aircraftname: "The Minivan", registration: "N-SAFE1", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 138, premiumEconomy: 18, business: 10, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.pilots = 2 + 2  // 2 for each A320, 2 for each B737-800NG
                                        userData.flightAttendents = 4 + 2 // 4 for each A320, 2 for each B737-800NG
                                        userData.accountBalance = 30500000
                                    } else if fleetChoice == 5 {
                                        // E175-E2
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "Fresh Off The Lot", registration: "N-NEWB01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.planes.append(FleetItem(aircraftID: "E175E2", aircraftname: "The Dawn of the Millenium", registration: "N-TECH01", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 70, premiumEconomy: 8, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        // E190-E2
                                        userData.planes.append(FleetItem(aircraftID: "E190E2", aircraftname: "Actually has WiFi", registration: "N-FANCY2", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 88, premiumEconomy: 12, business: 4, first: 0), kilometersTravelledSinceLastMaintainence: 0, currentAirportLocation: userData.deliveryHubs[0]))
                                        userData.pilots = 2 + 2 + 2 // 2 for each E175-E2, 2 for each E190-E2
                                        userData.flightAttendents = 2 + 2 + 3 // 2 for each E175-E2, 2 for each E190-E2
                                        userData.accountBalance = 34000000
                                    }
                                    
                                    userData.maintainanceCrew = userData.planes.count * 3
                                    /// For the stupid maintainance crew that I can't be bothered to add manually
                                    /// Will do 3 for each jet, based on planes added
                                    
                                    dismiss()
                                } label: {
                                    Image(systemName: "checkmark")
                                    Text("Finish setup!")
                                        .fontWidth(.condensed)
                                }
                                .buttonStyle(.borderedProminent)
                                .hoverEffect()
                        }
                    }
                }
                ScrollView {
                    FlowLayout() {
                        option(icon: "point.bottomleft.forward.to.point.topright.scurvepath", name: "The Regional Specialist", jet1: "CRJ900", jet2: "E175E2", jet1Full: "2x Bombardier CRJ900", jet2Full: "2x Embraer E175-E2", startingCapital: "$32.5M", focus: "Efficient connections of small, regional airports", option: 1)
                        
                        option(icon: "american.football", name: "The American Workhorse", jet1: "B737-800NG", jet2: "E175E2", jet1Full: "1x Boeing 737-800NG", jet2Full: "2x Embraer E175-E2", startingCapital: "$31.0M", focus: "Operations around a reliable, well-known workhorse.", option: 2)
                        
                        option(icon: "star", name: "The Eurasian Special", jet1: "A319", jet2: "CRJ900", jet1Full: "1x Airbus A319-100", jet2Full: "2x Bombardier CRJ900", startingCapital: "$30.5M", focus: "The perfect fleet for the European and Asian market.", option: 3)
                        
                        option(icon: "person.3", name: "The Domestic", jet1: "A320", jet2: "B737-800NG", jet1Full: "1x Airbus A320-200", jet2Full: "1x Boeing 737-800NG", startingCapital: "$30.5M", focus: "A fleet that maximises profits with modernity.", option: 4)
                        
                        option(icon: "star", name: "The Modern Pioneer", jet1: "E175E2", jet2: "E190E2", jet1Full: "2x Embraer E175-E2", jet2Full: "1x Embraer E190-E2", startingCapital: "$34.0M", focus: "Jets designed around efficiency and modernity.", option: 5)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }

        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if x + size.width > maxWidth {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        
        return CGSize(width: maxWidth, height: y + rowHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ()) {
        
        let maxWidth = bounds.width
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            view.place(at: CGPoint(x: x, y: y),
                       proposal: ProposedViewSize(size))
            
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
