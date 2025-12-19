//
//  SidebarItemThingy.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension MapView {
    // MARK: Sidebar item (when you open the plane, that thingy)
    func sidebarItemView(plane: Binding<FleetItem>) -> some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        selectedPlane = nil
                        indexOfSelectedPlane = -1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }
                Button {
                    withAnimation {
                        showSidebar = false
                    }
                } label: {
                    Image(systemName: "sidebar.left")
                        .padding(2)
                }
                .buttonStyle(.bordered)
                .background(.ultraThickMaterial)
                .matchedGeometryEffect(id: "sidebarBtn", in: namespace)
                Text(plane.aircraftID.wrappedValue)
                    .fontWidth(.condensed)
                Spacer()
            }
            
            Image(plane.aircraftID.wrappedValue)
                .resizable()
                .scaledToFit()
            
            HStack {
                Text(plane.registration.wrappedValue)
                    .fontWidth(.condensed)
                Spacer()
                Text(plane.aircraftname.wrappedValue)
                    .fontWidth(.condensed)
            }
            HStack {
                if plane.wrappedValue.assignedRoute == nil {
                    Text("No assigned route")
                        .fontWidth(.condensed)
                } else {
                    //                    if plane.wrappedValue.assignedRoute!.stopoverAirport == nil {
                    //                        Text("Plane flies from \(plane.wrappedValue.assignedRoute!.originAirport.iata) to \(plane.wrappedValue.assignedRoute!.arrivalAirport.iata)")
                    //                            .fontWidth(.condensed)
                    //                    } else {
                    Text("Plane flies from \(plane.wrappedValue.assignedRoute!.originAirport.reportCorrectCodeForUserData(userData)) to \(plane.wrappedValue.assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))")
                        .fontWidth(.condensed)
                    //                    }
                }
                Spacer()
            }
            if plane.wrappedValue.assignedRoute != nil && !plane.wrappedValue.isAirborne {
                VStack {
                    VStack {
                        editableLittleSmallBoxThingy(icon: "carseat.right", item: plane.assignedPricing.economy, placeholder: "$50")
                        editableLittleSmallBoxThingy(icon: "star", item: plane.assignedPricing.premiumEconomy, placeholder: "$100")
                    }
                    VStack {
                        editableLittleSmallBoxThingy(icon: "briefcase", item: plane.assignedPricing.business, placeholder: "$150")
                        editableLittleSmallBoxThingy(icon: "crown", item: plane.assignedPricing.first, placeholder: "$200")
                    }
                }
                .transition(.blurReplace)
            }

            
            VStack {
                HStack {
                    Text("Change airports")
                        .fontWidth(.expanded)
                    Spacer()
                    Button {
                        planeFleetItemToChangeIndex = userData.planes.firstIndex(of: plane.wrappedValue) ?? planeFleetItemToChangeIndex
                        airportType = .arrival
                        maxRangeOfSelectedJet = Int(aircraftDatabase.aircraft(byCode: plane.wrappedValue.aircraftID)!.maxRange)
                        currentLocationOfPlane = plane.wrappedValue.currentAirportLocation!
                        withAnimation {
                            showAirportPicker = true
                            selectedPlane = nil
                            indexOfSelectedPlane = -1
                        }   
                    } label: {
                        Text("Arrival")
                            .fontWidth(.condensed)
                        
                    }
                }
                if !plane.wrappedValue.isAirborne && plane.wrappedValue.assignedRoute != nil && !plane.wrappedValue.inMaintainance && plane.wrappedValue.condition > 0.15 {
                    HStack {
                        Text("Depart Plane")
                            .fontWidth(.expanded)
                        Spacer()
                        Button {
                            let departureStatus = plane.wrappedValue.departJet($userData)
                            print(departureStatus)
                            if departureStatus.departedSuccessfully {
                                takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: [plane.wrappedValue],
                                                                                    economyPassenegersServed: departureStatus.seatsUsedInPlane!.economy,
                                                                                    premiumEconomyPassenegersServed: departureStatus.seatsUsedInPlane!.premiumEconomy,
                                                                                    businessPassengersServed: departureStatus.seatsUsedInPlane!.business,
                                                                                    firstClassPassengersServed: departureStatus.seatsUsedInPlane!.first,
                                                                                    maxEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.economy,
                                                                                    maxPremiumEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.premiumEconomy,
                                                                                    maxBusinessPassengersServed: departureStatus.seatingConfigOfJet!.business,
                                                                                    maxFirstClassPassengersServed: departureStatus.seatingConfigOfJet!.first,
                                                                                    moneyMade: departureStatus.moneyMade!)
                                withAnimation {
                                    showTakeoffPopup = true
                                }
                            }
                        } label: {
                            Text("Depart")
                                .fontWidth(.condensed)
                            
                        }
                    }
                } else if plane.wrappedValue.isAirborne {
                    if plane.wrappedValue.landingTime != nil {
                        TimelineView(.periodic(from: .now, by: 1.0))  { context in
                            HStack {
                                Text("_\(plane.wrappedValue.timeTakenForJetToReturn(context.date)) to reach_")
                                    .fontWidth(.condensed)
                                    .contentTransition(.numericText(countsDown: true))
                                    .id(refreshTimer)
                                Spacer()
                            }
                        }
                    }
                } else if plane.wrappedValue.condition <= 0.15 {
                    HStack {
                        Text("Plane cannot fly due to poor condition")
                            .fontWidth(.condensed)
                        Spacer()
                        if $userData.wrappedValue.accountBalance > AircraftDatabase.shared.allAircraft.first(where: { plane.wrappedValue.aircraftID == $0.modelCode })!.maintenanceCostPerHour * (plane.wrappedValue.hoursFlown - plane.wrappedValue.lastHoursOfPlaneDuringMaintainance) {
                            Button {
                                $userData.wrappedValue.accountBalance -= AircraftDatabase.shared.allAircraft.first(where: { plane.wrappedValue.aircraftID == $0.modelCode })!.maintenanceCostPerHour * (plane.wrappedValue.hoursFlown - plane.wrappedValue.lastHoursOfPlaneDuringMaintainance)
                            } label: {
                                Text("$\((AircraftDatabase.shared.allAircraft.first(where: { plane.wrappedValue.aircraftID == $0.modelCode })!.maintenanceCostPerHour * (plane.wrappedValue.hoursFlown - plane.wrappedValue.lastHoursOfPlaneDuringMaintainance)).withCommas)")
                            }
                        }
                    }
                }
                /// Price for jets
                if plane.wrappedValue.assignedRoute != nil {
                    VStack {
                        littleSmallBoxField(icon: "carseat.right", item: Binding(get: { plane.wrappedValue.assignedPricing.economy }, set: { plane.wrappedValue.assignedPricing.economy = $0 }))
                        littleSmallBoxField(icon: "star", item: Binding(get: { plane.wrappedValue.assignedPricing.premiumEconomy }, set: { plane.wrappedValue.assignedPricing.premiumEconomy = $0 }))
                        littleSmallBoxField(icon: "briefcase", item: Binding(get: { plane.wrappedValue.assignedPricing.business }, set: { plane.wrappedValue.assignedPricing.business = $0 }))
                        littleSmallBoxField(icon: "crown", item: Binding(get: { plane.wrappedValue.assignedPricing.first }, set: { plane.wrappedValue.assignedPricing.first = $0 }))
                    }
                }
                
                /// For the repair mechanics
                if !plane.wrappedValue.inMaintainance && plane.wrappedValue.condition != 1.0 {
                    if !plane.wrappedValue.isAirborne {
                        VStack {
                            ProgressView(value: plane.wrappedValue.condition) {
                                HStack {
                                    Text("Condition: \((selectedPlane!.condition * 100).withCommas)% worn")
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Button {
                                        plane.wrappedValue.setJetUnderMaintainance($userData)
                                        let notificationsManager = NotificationsManager()
                                        notificationsManager.schedule(notificationType: .maintainanceEnd, planeInvolved: plane.wrappedValue, date: plane.wrappedValue.endMaintainanceDate!, userData: userData)
                                    } label: {
                                        Text("Repair")
                                            .fontWidth(.condensed)
                                    }
                                    .disabled(AircraftDatabase.shared.allAircraft.first(where: { $0.id == plane.wrappedValue.aircraftID })!.maintenanceCostPerHour * plane.wrappedValue.lastHoursOfPlaneDuringMaintainance > userData.accountBalance)
                                }
                            }
                        }
                    }
                } else if plane.wrappedValue.endMaintainanceDate != nil {
                    TimelineView(.periodic(from: .now, by: 1.0))  { context in
                        HStack {
                            Text("\(plane.wrappedValue.timeTakenForJetToGetOutOfMaintainance(context.date)) to finish maintainace")
                                .fontWidth(.condensed)
                                .contentTransition(.numericText(countsDown: true))
                            Spacer()
                        }
                    }
                }
                
                HStack {
                    // For future implementations, add the stopover
                }
            }
            Spacer()
        }
    }
}
