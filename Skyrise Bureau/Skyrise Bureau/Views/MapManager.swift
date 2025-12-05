//
//  MapManager.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import MapKit
import SwiftUI

struct MapManagerView: View {
    @Namespace var mapScope
    @Namespace var namespace
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @State var temporarilySelectedAirportToGetMoreInformationOn: Airport? = nil
    @State var selectedPlane: FleetItem? = nil
    @Environment(\.colorScheme) var colorScheme
    @Binding var userData: UserData
    @State var sidebarWidth: Float = 300
    @State var selectedJet: Int? = nil
    @State var showSidebar: Bool = true
    
    var body: some View {
        GeometryReader { reader in
            // map item
            ZStack(alignment: .bottomLeading) {
                Map {
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
                .onAppear {
                    print("Loaded view")
                }
                .mapStyle(mapType)
                .mapControls {
                    MapPitchToggle(scope: mapScope)
                    MapCompass(scope: mapScope)
                    MapScaleView(scope: mapScope)
                }
            }
            
            HStack(spacing: 0) {
                VStack {
                    HStack(spacing: 0) {
                        if selectedJet == nil {
                            VStack {
                                HStack {
                                    if #available(iOS 26.0, *) {
                                        (Text(userData.airlineName)
                                            .fontWidth(.expanded)
                                            .font(.title)
                                         +
                                         Text("\nmanaged by \(userData.name)")
                                            .fontWidth(.condensed))
                                        .containerCornerOffset(.leading, sizeToFit: true)
                                    } else {
                                        (Text(userData.airlineName)
                                            .fontWidth(.expanded)
                                            .font(.title)
                                         +
                                         Text("\nmanaged by \(userData.name)")
                                            .fontWidth(.condensed))                                }
                                    Spacer()
                                }
                                
                                ScrollView {
                                    ForEach(userData.planes, id: \.id) { plane in
                                        Button {
                                            withAnimation {
                                                selectedJet = userData.planes.firstIndex(where: { $0.id == plane.id })!
                                            }
                                        } label: {
                                            planeItemView(plane)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                
                                Spacer()
                            }
//                            .transition(.slide)
                            .transition(.move(edge: .leading))
                        } else {
                            selectedJetView()
                                .transition(.move(edge: .trailing))
                        }

                    }
                    .padding()
                    .frame(width: CGFloat(sidebarWidth + 10), height: reader.size.height - 30)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                }
                Rectangle()
                    .frame(width: 10)
                    .foregroundStyle(.clear)
                    .contentShape(Rectangle())
                .gesture(DragGesture().onChanged { value in
                    let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                    self.sidebarWidth = Float(CGFloat(min(500, max(150, newWidth))))
                })
                .onChange(of: reader.size.width) {
                    if sidebarWidth > Float(reader.size.width) - 40 {
                        sidebarWidth = Float(reader.size.width) - 40
                    }
                }
                .onChange(of: sidebarWidth) {
                    if sidebarWidth > Float(reader.size.width) - 40 {
                        sidebarWidth = Float(reader.size.width) - 40
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapManagerView(userData: .constant(testUserDataEndgame))
}
