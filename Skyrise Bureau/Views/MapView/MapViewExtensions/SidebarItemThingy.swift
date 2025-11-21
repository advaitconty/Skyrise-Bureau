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
                if plane.assignedRoute == nil {
                    Text("No assigned route")
                        .fontWidth(.condensed)
                } else {
                    if plane.wrappedValue.assignedRoute!.stopoverAirport == nil {
                        Text("Plane flies from \(plane.wrappedValue.assignedRoute!.originAirport.iata) to \(plane.wrappedValue.assignedRoute!.arrivalAirport.iata)")
                            .fontWidth(.condensed)
                    } else {
                        Text("Plane flies from \(plane.wrappedValue.assignedRoute!.originAirport.iata) to \(plane.wrappedValue.assignedRoute!.arrivalAirport.iata) via \(plane.wrappedValue.assignedRoute!.stopoverAirport)")
                            .fontWidth(.condensed)
                    }
                }
                Spacer()
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
                        }
                    } label: {
                        Text("Arrival")
                            .fontWidth(.condensed)
                        
                    }
                }
                if plane.wrappedValue.isAirborne {
                    HStack {
                        Text("Depart Plane")
                            .fontWidth(.expanded)
                        Spacer()
                        Button {
                            var departureStatus = plane.wrappedValue.departJet($userData)
                            if departureStatus != nil {
                                showTakeoffPopup = true
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
                            }
                        } label: {
                            Text("Depart")
                                .fontWidth(.condensed)
                            
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
