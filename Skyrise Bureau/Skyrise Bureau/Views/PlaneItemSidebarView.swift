//
//  PlaneItemView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI

extension MapManagerView {
    func planeItemView(_ plane: FleetItem) -> some View {
        VStack {
            HStack {
                Text(plane.aircraftname)
                    .fontWidth(.expanded)
                +
                Text("\n\(plane.aircraftID)")
                    .fontWidth(.condensed)
                Spacer()
                Text(plane.registration)
                    .fontWidth(.compressed)
            }
            if plane.assignedRoute != nil {
                if plane.isAirborne {
                    VStack {
                        HStack {
                            Text("Plane is flying from \(plane.assignedRoute!.originAirport.reportCorrectCodeForUserData(userData)) to \(plane.assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                        HStack {
                            TimelineView(.periodic(from: .now, by: 1)) { context in
                                Text("Landing in \(plane.timeTakenForJetToReturn(context.date))")
                                    .fontWidth(.condensed)
                            }
                            Spacer()
                        }
                    }
                } else {
                    HStack {
                        Text("Plane is currently on the ground at \(plane.currentAirportLocation!.reportCorrectCodeForUserData(userData)). Assigned to fly from \(plane.assignedRoute!.originAirport.reportCorrectCodeForUserData(userData)) to \(plane.assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))")
                            .fontWidth(.condensed)
                        Spacer()
                    }
                }
            } else {
                HStack {
                    Text("No assigned route. Currently at \(plane.currentAirportLocation!.reportCorrectCodeForUserData(userData))")
                        .fontWidth(.condensed)
                    Spacer()
                }
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}
