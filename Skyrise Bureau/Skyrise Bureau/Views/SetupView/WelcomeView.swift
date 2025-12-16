//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import SwiftUI

struct SetupView: View {
    @Binding var userData: UserData
    @State var screenNum: Int = 1
    @State var moveOnFromInitialAnimation: Bool = false
    @State var selectedStartingAirport: Airport = AirportDatabase.shared.allAirports.randomElement()!
    @State var fleetChoice: Int = 0
    @State var carousellItem: Int = 1
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if screenNum == 1 {
                firstScreenView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if screenNum == 2 {
                AirportPickerView(airportSelected: $selectedStartingAirport, userData: userData, finishedPickingScreen: Binding {
                    return !(screenNum == 2)
                } set: {
                    if $0 {
                        withAnimation {
                            screenNum = 3
                        }
                    }
                })
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if screenNum == 3 {
                thirdScreen()
                    .padding()
                    .onAppear { userData.deliveryHubs.append(selectedStartingAirport) }
            }
        }
    }
}
