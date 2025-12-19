//
//  AirportPickerView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import SwiftUI
import MapKit

struct AirportPickerView: View {
    @Binding var airportSelected: Airport
    var airportSelectionText: String = "Select your first airport"
    @State var searchTerm: String = ""
    var airportDatabase: AirportDatabase = AirportDatabase()
    var disallowedAirports: [Airport] = []
    var userData: UserData
    var maxRange: Int = 0
    var startAirport: Airport? = nil
    @Environment(\.dismiss) var dismiss
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @Binding var finishedPickingScreen: Bool
    
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
                mapItem()
                    .ignoresSafeArea()
                
                HStack {
                    VStack {
                        sidebarView(height: reader.size.height)
                    }
                    .padding()
                    VStack {
                        if #available(iOS 26.0, *) {
                            HStack {
                                Text(airportSelectionText)
                                    .font(.largeTitle)
                                    .fontWidth(.expanded)
                                Spacer()
                                Button {
                                    withAnimation {
                                        finishedPickingScreen = true
                                    }
                                    if startAirport != nil {
                                        dismiss()
                                    }
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                        .fontWidth(.condensed)
                                }
                                .buttonStyle(.glass)
                                .hoverEffect()
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
                                Button {
                                    withAnimation {
                                        finishedPickingScreen = true
                                    }
                                    if startAirport != nil {
                                        dismiss()
                                    }
                                } label: {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                }
                                .buttonStyle(.bordered)
                                .hoverEffect()
                                
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .padding()
                        }
                        Spacer()
                            .onChange(of: airportSelected) { oldValue, newValue in
                                withAnimation {
                                    mapCameraPosition = .region(MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: airportSelected.latitude, longitude: airportSelected.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    ))
                                }
                            }
                    }
                }
            }
        }
    }
}
