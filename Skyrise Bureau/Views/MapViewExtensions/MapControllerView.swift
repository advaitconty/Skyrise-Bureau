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
                        Annotation(airport.iata, coordinate: airport.clLocationCoordinateItemForLocation) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(colorScheme == .dark ? Color.cyan : Color.black)
                                Text(airport.iata)
                                    .foregroundStyle(colorScheme == .dark ? .black : .cyan)
                                    .padding(5)
                                    .fontWidth(temporarilySelectedAirportToGetMoreInformationOn == airport ? .expanded : .compressed)
                            }
                            .onTapGesture {
                                withAnimation {
                                    temporarilySelectedAirportToGetMoreInformationOn = airport
                                }
                                showTemporarilySelectedAirportToGetMoreInformationOnPopUp = true
                            }
                            .popover(isPresented: Binding(get: {
                                self.showTemporarilySelectedAirportToGetMoreInformationOnPopUp && self.temporarilySelectedAirportToGetMoreInformationOn == airport
                            },set: {
                                self.showTemporarilySelectedAirportToGetMoreInformationOnPopUp = $0
                            })) {
                                mapView(airport)
                                    .onAppear {
                                        print("shown")
                                    }
                            }
                        }
                    }
                    ForEach(userData.planes.compactMap { plane -> (FleetItem, Airport)? in
                        guard let location = plane.currentAirportLocation else { return nil }
                        return (plane, location)
                    }, id: \.0.id) { plane, location in
                        
                        Annotation(plane.aircraftname, coordinate: plane.planeLocationInFlight) {
                            Image(systemName: "airplane")
                                .font(.system(size: 15))
                                .rotationEffect(
                                    Angle(degrees:
                                            plane.assignedRoute != nil
                                          ? getBearing(from: location,
                                                       to: plane.assignedRoute!.arrivalAirport)
                                          : Double.random(in: 0...360)
                                         )
                                )
                                .shadow(radius: 10)
                                .foregroundStyle(plane == selectedPlane ? .indigo : .blue)
                                .offset(x: 15, y: 15)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPlane = plane
                                    }
                                }
                        }
                        
                        if let route = plane.assignedRoute {
                            MapPolyline(coordinates: [
                                route.originAirport.clLocationCoordinateItemForLocation,
                                route.arrivalAirport.clLocationCoordinateItemForLocation
                            ])
                            .stroke(.blue, lineWidth: 5)
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
