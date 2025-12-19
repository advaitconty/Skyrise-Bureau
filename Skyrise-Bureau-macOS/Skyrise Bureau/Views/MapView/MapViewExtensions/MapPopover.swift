//
//  MapPopover.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension MapView {
    // MARK: Popover for map
    func mapView(_ airport: Airport) -> some View {
        VStack {
            HStack {
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
        .padding()
    }
}
