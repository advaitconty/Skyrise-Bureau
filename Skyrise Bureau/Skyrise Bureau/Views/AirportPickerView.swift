//
//  AirportPickerView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import SwiftUI
import MapKit

struct AirportPickerView: View {
    @State var airportSelected: Airport = AirportDatabase.shared.allAirports.randomElement()!
    let airportSelectionText: String = "Select your first airport"
    @State var searchTerm: String = ""
    var airportDatabase: AirportDatabase = AirportDatabase()
    var disallowedAirports: [Airport] = []
    let userData: UserData
    let maxRange: Int = 0
    let startAirport: Airport? = nil
    
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
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .topLeading) {
                Map {
                    let info = DeviceInfo.modelAndIsMSeries
                    if info.isMSeries {
                        if #available(iOS 26, *) {
                        ForEach(filteredAirports, id: \.uniqueID) { airport in
                            Annotation(airport.name, coordinate: airport.clLocationCoordinateItemForLocation) {
                                ZStack {
                                if airportSelected == airport {
                                    Color.accentColor
                                        .clipShape(Capsule())
                                }
                                    Text(airport.reportCorrectCodeForUserData(userData))
                                        .fontWidth(airportSelected == airport ? .expanded : .condensed)
                                        .padding()
                                }
                                .glassEffect()
                            }
                        }
                        } else {
                            ForEach(filteredAirports, id: \.uniqueID) { airport in
                                Annotation(airport.name, coordinate: airport.clLocationCoordinateItemForLocation) {
                                    ZStack {
                                        Text(airport.reportCorrectCodeForUserData(userData))
                                            .fontWidth(airportSelected == airport ? .expanded : .condensed)
                                            .padding(5)
                                    }
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 7.5))
                                }
                            }
                        }
                    } else {
                        ForEach(filteredAirports, id: \.uniqueID) { airport in
                            Annotation(airport.name, coordinate: airport.clLocationCoordinateItemForLocation) {
                                ZStack {
                                    Text(airport.reportCorrectCodeForUserData(userData))
                                        .fontWidth(airportSelected == airport ? .expanded : .condensed)                                        .padding(5)
                                }
                                .background(.cyan)
                                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                            }
                        }
                    }
            }
            .ignoresSafeArea()
            
            HStack {
                VStack {
                    VStack {
                        if #available(iOS 26.0, *) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Some airport name...", text: $searchTerm)
                                    .fontWidth(.condensed)
                            }
                            .padding()
                            .glassEffect()

                        } else {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Some airport name...", text: $searchTerm)
                                    .fontWidth(.condensed)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding()
                        }
                        ScrollView {
                            ForEach(filteredAirports, id: \.uniqueID) { airport in
                                if airport == airportSelected {
                                    Button {
                                        withAnimation {
                                            airportSelected = airport
                                        }
                                    } label: {
                                        VStack {
                                            HStack {
                                                Text(airport.name)
                                                    .font(.title)
                                                    .fontWidth(.expanded)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("\(airport.iata) (\(airport.icao))")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text(airport.region.rawValue)
                                                    .fontWidth(.condensed)
                                            }
                                            HStack {
                                                Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text("Elevation: \(airport.elevation)m")
                                                    .fontWidth(.condensed)
                                            }
                                        }
                                        .padding()
                                        .background(.indigo)
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    }
                                    .buttonStyle(.plain)
                                } else {
                                    Button {
                                        withAnimation {
                                            airportSelected = airport
                                        }
                                    } label: {
                                        VStack {
                                            HStack {
                                                Text(airport.name)
                                                    .font(.title)
                                                    .fontWidth(.expanded)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("\(airport.iata) (\(airport.icao))")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text(airport.region.rawValue)
                                                    .fontWidth(.condensed)
                                            }
                                            HStack {
                                                Text("Max Runway length: \(airport.runwayLength.withCommas)m")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text("Elevation: \(airport.elevation)m")
                                                    .fontWidth(.condensed)
                                            }
                                        }
                                        .padding()
                                        .background(.ultraThickMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: CGFloat(300), height: reader.size.height - 30)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                .padding()
                VStack {
                    if #available(iOS 26.0, *) {
                        HStack {
                            Text(airportSelectionText)
                                .font(.largeTitle)
                                .fontWidth(.expanded)
                            Spacer()
                            if #available(iOS 26.0, *) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                        .fontWidth(.condensed)
                                }
                                .buttonStyle(.glass)
                                .hoverEffect()
                            } else {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                }
                                .buttonStyle(.bordered)
                                .hoverEffect()
                            }
                        }
                        .padding()
                        .glassEffect()
                        .padding()
                    } else {
                        HStack {
                            Text(airportSelectionText)
                                .font(.largeTitle)
                                .fontWidth(.expanded)
                            Spacer()
                            if #available(iOS 26.0, *) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                        .fontWidth(.condensed)
                                }
                                .buttonStyle(.glass)
                                .hoverEffect()
                            } else {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                }
                                .buttonStyle(.bordered)
                                .hoverEffect()
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}
}

#Preview {
    AirportPickerView(userData: testUserData)
}
