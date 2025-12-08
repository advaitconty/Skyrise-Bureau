//
//  MapItem.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI
import MapKit

extension AirportPickerView {
    func mapItem() -> some View {
        Map(position: $mapCameraPosition) {
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
                        .onTapGesture {
                            withAnimation {
                                airportSelected = airport
                            }
                        }
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
                            
                            .onTapGesture {
                                
                                withAnimation {
                                    airportSelected = airport
                                }
                            }
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
                        
                        .onTapGesture {
                            
                            withAnimation {
                                airportSelected = airport
                            }
                        }
                    }
                }
            }
    }

    }
}
