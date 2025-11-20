//
//  UserUpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

struct UserUpgradeView: View {
    @Binding var userData: UserData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField(userData.airlineName, text: $userData.airlineName)
                        .textFieldStyle(.plain)
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text("As managed by ".uppercased())
                        .font(.caption2)
                        .fontWidth(.expanded)
                    TextField(userData.name, text: $userData.name)
                        .textFieldStyle(.plain)
                        .font(.caption2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Text("ACTIVE RESERVES: $\(userData.accountBalance.withCommas)".uppercased())
                        .font(.caption2)
                        .fontWidth(.expanded)
                    Spacer()
                }
            }
            ScrollView {
                /// This is gonna be a v2 feature, will be a non-issue
//                paycheckView()
                
                // MARK: Airline Stats Start
                HStack {
                    Text("AIRLINE INFO")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                // Hub airports
                hubAirportsView()
                
                // Planes
                planeStatsViewForUpgrades()
            }
        }
        .padding()
    }
}

#Preview {
    UserUpgradeView(userData: .constant(testUserDataEndgame))
}
