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
    @State var cameraPosition: MapCameraPosition = .automatic
    @Binding var userData: UserData
    @State var selectedPlane: FleetItem? = nil
    @State var showAirportPicker: Bool = false
    @State var userDoneSelectedAirport: Bool = false
    @State var aircraftDatabase: AircraftDatabase = AircraftDatabase()
    @State var temporarilySelectedAirportHolderVariableThingamajik: Airport = Airport(
        name: "Toronto Pearson International Airport",
        city: "Toronto",
        country: "Canada",
        iata: "YYZ",
        icao: "CYYZ",
        region: .northAmerica,
        latitude: 43.6777,
        longitude: -79.6248,
        runwayLength: 3389,
        elevation: 173,
        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
    )
    @State var planeFleetItemToChangeIndex: Int = 0
    /// Temporarily held like this
    @State var airportType:  AirportType = .arrival
    @State var maxRangeOfSelectedJet: Int = 0
    @State var currentLocationOfPlane: Airport = Airport(
        name: "Toronto Pearson International Airport",
        city: "Toronto",
        country: "Canada",
        iata: "YYZ",
        icao: "CYYZ",
        region: .northAmerica,
        latitude: 43.6777,
        longitude: -79.6248,
        runwayLength: 3389,
        elevation: 173,
        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
    )
    
    
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
                        .listStyle(.bordered)
                        Spacer()
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
                                    .fontWidth(.compressed)
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
    
    var body: some View {
        VStack {
            if !showAirportPicker {
                regularMapView()
                    .transition(.move(edge: .top))
            } else {
                AirportPickerView(maxRange: maxRangeOfSelectedJet, startAirport: currentLocationOfPlane, moveOn: $userDoneSelectedAirport, finalAirportSelected: $temporarilySelectedAirportHolderVariableThingamajik)
                    .transition(.move(edge: .top))
                    .padding()
            }
        }
        .onChange(of: userDoneSelectedAirport) { originalValue, newValue in
            if newValue {
                if userData.planes[planeFleetItemToChangeIndex].assignedRoute == nil {
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute = Route(originAirport: Airport(
                        name: "Toronto Pearson International Airport",
                        city: "Toronto",
                        country: "Canada",
                        iata: "YYZ",
                        icao: "CYYZ",
                        region: .northAmerica,
                        latitude: 43.6777,
                        longitude: -79.6248,
                        runwayLength: 3389,
                        elevation: 173,
                        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
                        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
                    ), arrivalAirport: Airport(
                        name: "Toronto Pearson International Airport",
                        city: "Toronto",
                        country: "Canada",
                        iata: "YYZ",
                        icao: "CYYZ",
                        region: .northAmerica,
                        latitude: 43.6777,
                        longitude: -79.6248,
                        runwayLength: 3389,
                        elevation: 173,
                        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
                        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
                    ))
                }
                switch airportType {
                case .departure:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.originAirport = temporarilySelectedAirportHolderVariableThingamajik
                case .arrival:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.arrivalAirport = temporarilySelectedAirportHolderVariableThingamajik
                case .stopover:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.stopoverAirport = temporarilySelectedAirportHolderVariableThingamajik
                }
                userData.planes[planeFleetItemToChangeIndex].assignedRoute?.originAirport = userData.planes[planeFleetItemToChangeIndex].currentAirportLocation!
                print(userData.planes[planeFleetItemToChangeIndex].assignedRoute)
                userDoneSelectedAirport = false
            }
            withAnimation {
                showAirportPicker = false
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
