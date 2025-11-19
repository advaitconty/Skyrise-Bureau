//
//  SidebarItemThingy.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension MapView {
    // MARK: Sidebar item (when you open the plane, that thingy)
    func sidebarItemView(plane: FleetItem) -> some View {
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
                Text(plane.aircraftID)
                    .fontWidth(.condensed)
                Spacer()
            }
            
            Image(plane.aircraftID)
                .resizable()
                .scaledToFit()
            
            HStack {
                Text(plane.registration)
                    .fontWidth(.condensed)
                Spacer()
                Text(plane.aircraftname)
                    .fontWidth(.condensed)
            }
            HStack {
                if plane.assignedRoute == nil {
                    Text("No assigned route")
                        .fontWidth(.condensed)
                } else {
                    if plane.assignedRoute!.stopoverAirport == nil {
                        Text("Plane flies from \(plane.assignedRoute!.originAirport.iata) to \(plane.assignedRoute!.arrivalAirport.iata)")
                            .fontWidth(.condensed)
                    } else {
                        Text("Plane flies from \(plane.assignedRoute!.originAirport.iata) to \(plane.assignedRoute!.arrivalAirport.iata) via \(plane.assignedRoute!.stopoverAirport)")
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
                        planeFleetItemToChangeIndex = userData.planes.firstIndex(of: plane) ?? planeFleetItemToChangeIndex
                        airportType = .arrival
                        maxRangeOfSelectedJet = Int(aircraftDatabase.aircraft(byCode: plane.aircraftID)!.maxRange)
                        currentLocationOfPlane = plane.currentAirportLocation!
                        withAnimation {
                            showAirportPicker = true
                        }
                    } label: {
                        Text("Arrival")
                            .fontWidth(.condensed)
                        
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
