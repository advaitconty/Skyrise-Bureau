//
//  planeStatsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension UserUpgradeView {
    func planeItemView(_ plane: Binding<FleetItem>) -> some View {
        VStack {
            Image(plane.aircraftID.wrappedValue)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5.0))

            TextField("Aircraft Name", text: plane.aircraftname)
                .textFieldStyle(.plain)
                .font(.subheadline)
                .fontWidth(.expanded)
            HStack {
                Text(plane.aircraftID.wrappedValue)
                    .font(.caption)
                    .fontWidth(.condensed)
                TextField("Registration", text: plane.registration)
                    .textFieldStyle(.plain)
                    .font(.caption)
                    .fontWidth(.condensed)
                    .multilineTextAlignment(.trailing)
            }
            Text("\(Int(plane.hoursFlown.wrappedValue).withCommas)h flown - \(plane.isAirborne.wrappedValue ? "currently flying" : plane.currentAirportLocation.wrappedValue.map { "at \($0.reportCorrectCodeForUserData(userData.wrappedValue))" } ?? "unknown location")")
                .font(.caption)
                .fontWidth(.condensed)
        }
        .padding(5)
        .frame(width: 150, height: 160)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
    
    func planeStatsViewForUpgrades() -> some View {
        VStack {
            HStack {
                Text("\(userData.planes.count) Airplanes owned".uppercased())
                    .fontWidth(.expanded)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(userData.planes, id: \.id) { plane in
                        planeItemView(plane)
                    }
                }
            }
        }
    }
}
