//
//  MapView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map {
            ForEach(AirportDatabase.shared.allAirports, id: \.id) { airport in
                
                Annotation(airport.name, coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black)
                        Text(airport.iata)
                            .foregroundStyle(.cyan)
                            .padding(5)
                            .fontWidth(.compressed)
                    }
                }
            }
        }
        .mapControls {
            MapPitchToggle()
            MapCompass()
            MapScaleView()
            MapUserLocationButton()
            MapZoomStepper()
        }
    }
}

#Preview {
    MapView()
}
