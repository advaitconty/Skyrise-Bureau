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
        GeometryReader { reader in
            VStack(spacing:0) {
                VStack(spacing: 0) {
                    HStack {
                        Text(userData.airlineName)
                            .font(Font.caption2)
                            .fontWidth(.expanded)
                        +
                        Text(" - \((userData.airlineReputation * 100).withCommas)% known")
                            .font(Font.caption)
                            .fontWidth(.expanded)
                        Spacer()
                        Text("Balance: $\(userData.accountBalance.withCommas)")
                            .font(Font.caption)
                            .fontWidth(.condensed)
                    }
                    VStack {
                        ProgressView(value: userData.progressToNextXPLevel)
                            .onAppear {
                                print(userData.xp)
                                print(userData.xpPoints)
                                print(userData.progressToNextXPLevel)
                            }
                            .frame(height: 20)
                        HStack {
                            Text("Currently Level \(userData.levels)")
                                .font(.caption2)
                                .fontWidth(.expanded)
                            +
                            Text(" - \(userData.xpRequiredForNextXPLevel) XP to next level")
                                .font(.caption)
                                .fontWidth(.expanded)
                            Spacer()
                            Text("Holding Fuel: \(userData.currentlyHoldingFuel.withCommas)kg/\(userData.maxFuelHoldable.withCommas)kg")
                                .font(.caption)
                                .fontWidth(.condensed)
                        }
                    }
                }
                .padding()
                Rectangle()
                    .frame(height: 3)
                    .foregroundStyle(.gray.opacity(0.5))
                HStack(spacing: 0) {
                    if showSidebar {
                        sidebarView()
                            .frame(width: CGFloat(sidebarWidth))
                        // Handle for resizing: (this shit not working rn)
                        ZStack {
                            Rectangle()
                                .frame(width: 3)
                                .foregroundStyle(.gray.opacity(0.5))
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 10, height: 20)
                            HStack {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 10, height: 20)
                                    .foregroundStyle(.gray.opacity(0.5))
                            }
                        }
                        .gesture(DragGesture().onChanged { value in
                            let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                            self.sidebarWidth = Int(min(500, max(150, newWidth)))
                        })
                    }
                    
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
                    .frame(width: showSidebar ? reader.size.width - CGFloat(sidebarWidth) : reader.size.width)
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
    }
}
