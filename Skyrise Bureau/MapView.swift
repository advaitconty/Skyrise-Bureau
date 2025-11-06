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
            }
        }
        .padding()
        .transition(.move(edge: .leading))
        .frame(width: CGFloat(sidebarWidth))
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

#Preview {
    MapView()
}
