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
    @State var showMapSelector: Bool = false
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @AppStorage("mapType") var savedMapType: String = "Satelite"
    @Environment(\.colorScheme) var colorScheme
    
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
    
    var body: some View {
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
            }
            .mapStyle(mapType)
            .mapControls {
                MapPitchToggle(scope: mapScope)
                MapCompass(scope: mapScope)
                MapScaleView(scope: mapScope)
                MapZoomStepper(scope: mapScope)
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

#Preview {
    MapView()
}
