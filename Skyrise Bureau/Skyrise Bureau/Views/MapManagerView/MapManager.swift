//
//  MapManager.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import MapKit
import SwiftUI
import Combine

class Clock: ObservableObject {
    @Published var now = Date()
    private var timer = Timer()
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.now = Date()
        }
    }
}

struct MapManagerView: View {
    @State var airportSelector: Bool = false
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
    @StateObject var clock = Clock()
    @State var openSettings: Bool = false
    
    var body: some View {
        if UIDevice.current.isPad {
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
                                            .hoverEffect()
                                        }
                                    }
                                    
                                    Spacer()
                                    /// For the extras
                                    VStack {
                                        ProgressView(value: userData.progressToNextXPLevel) {
                                            HStack {
                                                Text("Level \(userData.levels)")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text("\(userData.xpRequiredForNextXPLevel) XP to next level")
                                                    .fontWidth(.condensed)
                                            }
                                        }
                                        HStack {
                                            Text("Balance: $\(userData.accountBalance.withCommas)")
                                                .fontWidth(.condensed)
                                            Spacer()
                                            Text("Reputation: \((userData.airlineReputation * 100).withCommas)%")
                                                .fontWidth(.condensed)
                                        }
                                        
                                        HStack {
                                            if #available(iOS 26.0, *) {
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "fuelpump")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "person.text.rectangle")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "cart")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    print("SUMMON")
                                                    openSettings = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "gearshape.2")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                            } else {
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "fuelpump")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "person.text.rectangle")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "cart")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    openSettings = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "gearshape.2")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                            }
                                        }
                                        
                                        // Statistics since toolbar hidden
                                        HStack {
                                            Text(clock.now.formatted(.dateTime.hour().minute()))
                                                .fontWidth(.expanded)
                                            Spacer()
                                            Text(clock.now, style: .date)
                                                .fontWidth(.compressed)
                                        }
                                    }
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
                            self.sidebarWidth = Float(CGFloat(min(500, max(250, newWidth))))
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
            .statusBarHidden(true)
            .ignoresSafeArea()
            .sheet(isPresented: $openSettings) {
                SettingsView(userData: $userData)
            }
            .fullScreenCover(isPresented: $airportSelector) {
                AirportPickerView(airportSelected: Binding {
                    return userData.planes[selectedJet!].assignedRoute!.arrivalAirport
                } set: {
                    userData.planes[selectedJet!].assignedRoute!.arrivalAirport = $0
                }, airportSelectionText: "Select your destination airport",
                                  userData: userData,
                                  maxRange: AircraftDatabase.shared.allAircraft.first(where: { $0.id == $userData.wrappedValue.planes[selectedJet!].aircraftID })!.maxRange,
                                  startAirport: userData.planes[selectedJet!].currentAirportLocation,
                                  finishedPickingScreen: Binding {
                    return !openSettings
                } set: {
                    print($0)
                    if $0 {
                        print("check")
                        openSettings = false
                    }
                })
            }
        } else if UIDevice.current.isPhone {
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
                                                .fontWidth(.condensed))
                                        }
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
                                            .hoverEffect()
                                        }
                                    }
                                }
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
            .sheet(isPresented: $openSettings) {
                SettingsView(userData: $userData)
            }
        }
    }
}

#Preview {
    MapManagerView(userData: .constant(testUserDataWithFlyingPlanes))
}
