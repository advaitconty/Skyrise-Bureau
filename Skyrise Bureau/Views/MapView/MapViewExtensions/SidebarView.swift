//
//  SidebarView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension MapView {
    // MARK: Actual sidebar item
    func sidebarView() -> some View {
        VStack {
            if selectedPlane == nil {
                Group {
                    HStack {
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
                        Text("Planes")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    
                    VStack {
                        if amountOfNotDepartedPlanes(userData) > 0 {
                            Button {
                                var jetsDepartedSuccessfully: [DepartureDoneSuccessfullyItems] = []
                                for (index, plane) in userData.planes.enumerated() {
                                    if !plane.isAirborne {
                                        let attempt = userData.planes[index].departJet($userData)
                                        if attempt.departedSuccessfully {
                                            jetsDepartedSuccessfully.append(attempt)
                                        }
                                    }
                                }
                                print(jetsDepartedSuccessfully)
                                var planesTakenOff: [FleetItem] = []
                                var economyPassengersServed: Int = 0
                                var premiumEconomyPassengersServed: Int = 0
                                var businessPassengersServed: Int = 0
                                var firstPassengersServed: Int = 0
                                
                                var maxEconomyPassengersServed: Int = 0
                                var maxPremiumEconomyPassengersServed: Int = 0
                                var maxBusinessPassengersServed: Int = 0
                                var maxFirstPassengersServed: Int = 0
                                
                                var totalMoneyMade: Double = 0
                                
                                for jetDepartedSuccessfully in jetsDepartedSuccessfully {
                                    planesTakenOff.append(jetDepartedSuccessfully.planeInfo ?? FleetItem(aircraftID: "somethong", aircraftname: "goasngo", registration: "gaogns", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 4, premiumEconomy: 41, business: 414, first: 41), kilometersTravelledSinceLastMaintainence: 4))
                                    economyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.economy
                                    premiumEconomyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.premiumEconomy
                                    businessPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.business
                                    firstPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.first
                                    maxEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.economy
                                    maxPremiumEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.premiumEconomy
                                    maxBusinessPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.business
                                    maxFirstPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.first
                                    totalMoneyMade += jetDepartedSuccessfully.moneyMade!
                                }
                                
                                takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: planesTakenOff, economyPassenegersServed: economyPassengersServed, premiumEconomyPassenegersServed: premiumEconomyPassengersServed, businessPassengersServed: businessPassengersServed, firstClassPassengersServed: firstPassengersServed, maxEconomyPassenegersServed: maxEconomyPassengersServed, maxPremiumEconomyPassenegersServed: maxPremiumEconomyPassengersServed, maxBusinessPassengersServed: maxBusinessPassengersServed, maxFirstClassPassengersServed: maxFirstPassengersServed, moneyMade: totalMoneyMade)
                                withAnimation {
                                    showTakeoffPopup = true
                                }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Depart all (\(amountOfNotDepartedPlanes(userData)) to depart)")
                                        .fontWidth(.condensed)
                                    Spacer()
                                }
                            }
                        }
                        ScrollView {
                            ForEach(userData.planes, id: \.id) { plane in
                                Button {
                                    withAnimation {
                                        selectedPlane = plane
                                    }
                                } label: {
                                    VStack {
                                        HStack {
                                            VStack {
                                                HStack {
                                                    Text("\(plane.aircraftname)")
                                                        .fontWidth(.condensed)
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text(plane.aircraftID)
                                                        .fontWidth(.condensed)
                                                        .font(.system(size: 12))
                                                    Spacer()
                                                }
                                            }
                                            Spacer()
                                            
                                            Text(plane.registration)
                                                .fontWidth(.compressed)
                                        }
                                        .onAppear {
                                            print(plane.assignedRoute)
                                        }
                                        VStack {
                                            if let assignedRoute = plane.assignedRoute {
                                                if let currentAirportLocation = plane.currentAirportLocation {
                                                    if let stopoverAirport = assignedRoute.stopoverAirport {
                                                    } else {
                                                        HStack {
                                                            Text("_Flying from \(assignedRoute.originAirport.iata) to \(assignedRoute.arrivalAirport.iata)_")
                                                                .fontWidth(.condensed)
                                                            Spacer()
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            
                                            if let currentAirportLocation = plane.currentAirportLocation {
                                                if !plane.isAirborne {
                                                    HStack {
                                                        Text("_Plane is sitting at \(currentAirportLocation.iata)_")
                                                            .fontWidth(.condensed)
                                                        Spacer()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(1)
                                }
                            }
                        }
                        Spacer()
                        HStack {
                            Button {
                                openWindow(id: "shop")
                            } label: {
                                Spacer()
                                Image(systemName: "cart")
                                Spacer()
                            }
//                            Button {
//                                // Settings spawner, to add later
//                            } label: {
//                                Spacer()
//                                Image(systemName: "gear")
//                                Spacer()
//                            }
                            Button {
                                openWindow(id: "attributes")
                            } label: {
                                Spacer()
                                Image(systemName: "person.text.rectangle")
                                Spacer()
                            }
                        }
                    }
                }
                .transition(.asymmetric(insertion: .slide, removal: .scale))
            } else {
                sidebarItemView(plane: Binding(get: { return selectedPlane! }, set: { selectedPlane = $0 } ))
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            }
        }
        .padding()
        .transition(.move(edge: .leading))
        .frame(width: CGFloat(sidebarWidth))
        .background(.ultraThinMaterial)
    }
}
