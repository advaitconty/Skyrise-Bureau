//
//  AirportPickerView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 12/11/25.
//

import SwiftUI
import MapKit

struct AirportPickerView: View {
    @State var airportText: String = "Please select your main hub of operations"
    @State var maxRange: Int
    let startAirport: Airport?
    @Binding var moveOn: Bool
    @State var searchTerm: String = ""
    @State var showMapForSelection: Bool = true
    @Environment(\.colorScheme) var colorScheme
    @State var selectedAirport: Airport? = nil
    @Namespace var mapScope
    @State var showMapSelector = false
    @State var savedMapType: String = "Normal"
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @State var cameraPosition: MapCameraPosition = .automatic
    @Binding var finalAirportSelected: Airport
    var airportDatabase: AirportDatabase = AirportDatabase()
    var disallowedAirports: [Airport] = []
    let userData: UserData
    
    var filteredAirports: [Airport] {
        AirportDatabase.shared.allAirports.filter { airport in
            let matchesSearch = searchTerm.isEmpty || airport.iata.localizedCaseInsensitiveContains(searchTerm) || airport.icao.localizedCaseInsensitiveContains(searchTerm) || airport.country.localizedCaseInsensitiveContains(searchTerm) || airport.city.localizedCaseInsensitiveContains(searchTerm) || airport.name.localizedCaseInsensitiveContains(searchTerm) ||    airport.region.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            let rangeMax: Bool
            if maxRange != 0 && startAirport != nil {
                rangeMax = airportDatabase.calculateDistance(from: startAirport!, to: airport) <= maxRange
            } else {
                rangeMax = true
            }
            
            let sameAirport = airport == startAirport
            return rangeMax && matchesSearch && !sameAirport && !disallowedAirports.contains(where: { $0.icao == airport.icao })
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
    
    func littleSmallBoxThingy(icon: String, item: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(item)
                .fontWidth(.condensed)
        }
        .padding(5)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "airplane.departure")
                Text(airportText)
                    .fontWidth(.expanded)
                Spacer()
                if selectedAirport != nil {
                    Button {
                        withAnimation {
                            finalAirportSelected = selectedAirport!
                        }
                        moveOn = true
                    } label: {
                        Image(systemName: "arrow.right")
                        Text("Next")
                            .fontWidth(.condensed)
                    }
                }
            }
            TextField("Search for various airports...", text: $searchTerm)
                .fontWidth(.condensed)
                .textFieldStyle(.roundedBorder)
            HStack {
                // MARK: Sidebar
                    ScrollView {
                        ForEach(filteredAirports, id: \.id) { airport in
                            VStack {
                                HStack(spacing: 0) {
                                    Text("\(countryNameToEmoji(airport.country)) ")
                                        .font(.title)
                                    Text("\(airport.name)")
                                        .font(.title)
                                        .fontWidth(.expanded)
                                    Spacer()
                                }
                                HStack {
                                    littleSmallBoxThingy(icon: "building.2", item: airport.city)
                                    littleSmallBoxThingy(icon: "airplane", item: "\(airport.reportCorrectCodeForUserData(userData))/\(airport.icao)")
                                    littleSmallBoxThingy(icon: "road.lanes", item: "\(airport.runwayLength)m")
                                    littleSmallBoxThingy(icon: "flag", item: "\(airport.country)")
                                }
                            }
                            .padding(5)
                            .background(selectedAirport == airport ? .blue : (colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .onTapGesture {
                                withAnimation {
                                    selectedAirport = airport
                                }
                            }
                        }
                    }
                if showMapForSelection {
                    ZStack(alignment: .topLeading) {
                        Map(position: $cameraPosition) {
                            ForEach(filteredAirports, id: \.id) { airport in
                                
                                Annotation(airport.name, coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(colorScheme == .dark ? Color.cyan : Color.black)
                                        Text(airport.reportCorrectCodeForUserData(userData))
                                            .font(airport == selectedAirport ? .largeTitle : .body)
                                            .foregroundStyle(colorScheme == .dark ? .black : .cyan)
                                            .padding(5)
                                            .fontWidth(airport == selectedAirport ? .expanded : .compressed)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedAirport = airport
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .mapStyle(mapType)
                        .onChange(of: selectedAirport) { oldValue, newValue in
                            if let airport = newValue {
                                withAnimation {
                                    cameraPosition = .region(MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    ))
                                }
                            }
                        }
                        .mapControls {
                            MapPitchToggle(scope: mapScope)
                            MapCompass(scope: mapScope)
                            MapScaleView(scope: mapScope)
                            MapZoomStepper(scope: mapScope)
                        }
                        VStack {
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
    }
}
