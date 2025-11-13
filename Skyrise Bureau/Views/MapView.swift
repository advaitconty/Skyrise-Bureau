//
//  MapView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Namespace var mapScope
    @Namespace var namespace
    @State var showMapSelector: Bool = false
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @AppStorage("mapType") var savedMapType: String = "Satelite"
    @Environment(\.colorScheme) var colorScheme
    @State var showSidebar: Bool = true
    @State var sidebarWidth: Int = 200
    @State var aircraftItem: FleetItem? = nil
    @Binding var userData: UserData
    
    func mapSelectView() -> some View {
        VStack {
            HStack {
                Text("Change map view")
                    .fontWidth(.expanded)
                
                Spacer()
            }
            HStack {
                Button {
                    savedMapType = "Normal"
                    mapType = .standard(elevation: .realistic, pointsOfInterest: .all)
                } label: {
                    VStack {
                        Image("Normal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 175)
                        
                        Text("Normal")
                            .fontWidth(.compressed)
                    }
                    .padding(3)
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke(Color.accentColor, lineWidth: savedMapType == "Normal" ? 2 : 0)
                    )
                }
                .buttonStyle(.borderless)
                
                
                Button {
                    savedMapType = "Satelite"
                    mapType = .hybrid(elevation: .realistic, pointsOfInterest: .all)
                } label: {
                    VStack {
                        Image("Satelite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 175)
                        
                        Text("Satellite")
                            .fontWidth(.compressed)
                    }
                    .padding(3)
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke(Color.accentColor, lineWidth: savedMapType == "Satelite" ? 2 : 0)
                    )
                }
                .buttonStyle(.borderless)
                
                
            }
        }
        .padding()
    }
    
    func sidebarView() -> some View {
        VStack {
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
                ScrollView {
                    ForEach(userData.planes, id: \.id) { plane in
                        Button {
                            aircraftItem = plane
                        } label: {
                            VStack {
                                HStack {
                                    VStack {
                                        HStack {
                                            Text(plane.aircraftname)
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
                                                    Text("_Flying from \(assignedRoute.destinationAirport.iata) to \(assignedRoute.arrivalAirport.iata)_")
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
                //                .popover(item: $aircraftItem, arrowEdge: .leading) { item in
                //                    VStack {
                //                        Text(item.aircraftID)
                //                    }
                //                }
                .listStyle(.bordered)
                Spacer()
            }
        }
        .padding()
        .transition(.move(edge: .leading))
        .frame(width: CGFloat(sidebarWidth))
        .background(.ultraThinMaterial)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if showSidebar {
                sidebarView()
            }
            // Handle for resizing:
            Divider()
                .opacity(0)
                .gesture(DragGesture().onChanged { value in
                    let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                    
                    self.sidebarWidth = Int(min(500, max(150, newWidth)))
                })
            
            ZStack(alignment: .topLeading) {
                Map {
                    ForEach(AirportDatabase.shared.allAirports, id: \.id) { airport in
                        Annotation(airport.name, coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(colorScheme == .dark ? Color.cyan : Color.black)
                                Text(airport.iata)
                                    .foregroundStyle(colorScheme == .dark ? .black : .cyan)
                                    .padding(5)
                                    .fontWidth(.compressed)
                            }
                        }
                    }
//                    ForEach(userData.planes) { plane in
//                        if let location = plane.currentAirportLocation {
//                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
//                                Image(systemName: "airplane")
//                                    .font(.system(size: 15))
//                                    .rotationEffect(Angle(degrees: plane.assignedRoute != nil ? getBearing(from: location, to: plane.assignedRoute!.arrivalAirport) : 45))
//                                    .shadow(radius: 10)
//                                    .foregroundStyle(.blue)
//                                    .offset(x: 15, y: 15)
//                            }
//                        }
//                    }
                    // swift on drugs bro, how tf does this work but not what's above
                    ForEach(userData.planes.compactMap { plane -> (FleetItem, Airport)? in
                        guard let location = plane.currentAirportLocation else { return nil }
                        return (plane, location)
                    }, id: \.0.id) { plane, location in
                        Annotation(plane.aircraftname, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                            Image(systemName: "airplane")
                                .font(.system(size: 15))
                                .rotationEffect(Angle(degrees: plane.assignedRoute != nil ? getBearing(from: location, to: plane.assignedRoute!.arrivalAirport) : 45))
                                .shadow(radius: 10)
                                .foregroundStyle(.blue)
                                .offset(x: 15, y: 15)
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
    
    func getBearing(from: Airport, to: Airport) -> Double {
        let lat1 = from.latitude * .pi / 180
        let lon1 = from.longitude * .pi / 180
        
        let lat2 = to.latitude * .pi / 180
        let lon2 = to.longitude * .pi / 180
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansBearing * 180 / .pi
    }
}

#Preview {
    MapView(userData: .constant(testUserData))
}
