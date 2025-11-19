//
//  MapControllerView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI
import MapKit

extension MapView {
    // MARK: Map Controller
    func regularMapView() -> some View {
        HStack(spacing: 0) {
            if showSidebar {
                sidebarView()
            }
            // Handle for resizing: (this shit not working rn)
            Divider()
                .opacity(0)
                .gesture(DragGesture().onChanged { value in
                    let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                    
                    self.sidebarWidth = Int(min(500, max(150, newWidth)))
                })
            
            ZStack(alignment: .topLeading) {
                Map(position: $cameraPosition) {
                    ForEach(AirportDatabase.shared.allAirports, id: \.id) { airport in
                        airportAnnotation(airport)
                    }
                    ForEach(userData.planes.compactMap { plane -> (FleetItem, Airport)? in
                        guard let location = plane.currentAirportLocation else { return nil }
                        return (plane, location)
                    }, id: \.0.id) { plane, location in
                        aircraftAnnotation(plane, location: location)
                        if let route = plane.assignedRoute {
                            aircraftRouteAnnotation(route)
                        }
                    }
                }
                .mapStyle(mapType)
                .mapControls {
                    MapPitchToggle(scope: mapScope)
                    MapCompass(scope: mapScope)
                    MapScaleView(scope: mapScope)
                    MapZoomStepper(scope: mapScope)
                }
                VStack {
                    if !showSidebar {
                        Button {
                            withAnimation {
                                showSidebar = true
                            }
                        } label: {
                            Image(systemName: "sidebar.left")
                                .padding(2)
                        }
                        .buttonStyle(.bordered)
                        .background(.ultraThickMaterial)
                        .matchedGeometryEffect(id: "sidebarBtn", in: namespace)
                    }
                    
                    Button {
                        showMapSelector = true
                    } label: {
                        Image(systemName: "map")
                            .padding(2)
                    }
                    .buttonStyle(.bordered)
                    .background(.ultraThickMaterial)
                    .popover(isPresented: $showMapSelector, arrowEdge: .bottom) {
                        mapSelectView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .padding()
            }
            .onAppear {
                if savedMapType == "Normal" {
                    mapType = .standard(elevation: .realistic, pointsOfInterest: .all)
                } else {
                    mapType = .hybrid(elevation: .realistic, pointsOfInterest: .all)
                }
            }
        }
    }
}
