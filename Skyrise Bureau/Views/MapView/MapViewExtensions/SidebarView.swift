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
                                for (index, plane) in userData.planes.enumerated() {
                                    if !plane.isAirborne {
                                        userData.planes[index].departJet(userData)
                                    }
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
                                                HStack {
                                                    Text("_Plane is sitting at \(currentAirportLocation.iata)_")
                                                        .fontWidth(.condensed)
                                                    Spacer()
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
                            Button {
                                // Settings spawner, to add later
                            } label: {
                                Spacer()
                                Image(systemName: "gear")
                                Spacer()
                            }
                            Button {
                                // Airline management screen, to manage attributes, logic to add later
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
                sidebarItemView(plane: selectedPlane!)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            }
        }
        .padding()
        .transition(.move(edge: .leading))
        .frame(width: CGFloat(sidebarWidth))
        .background(.ultraThinMaterial)
    }
}
