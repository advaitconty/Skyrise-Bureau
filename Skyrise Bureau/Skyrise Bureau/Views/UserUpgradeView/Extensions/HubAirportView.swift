//
//  HubAirportView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension UserUpgradeView {
    func airportItemView(_ airport: Airport) -> some View {
        VStack {
            Text("\(countryNameToEmoji(airport.country))\(airport.iata) (\(airport.icao))\n")
                .fontWidth(.expanded)
            +
            Text(airport.name)
                .fontWidth(.condensed)
        }
        .padding(5)
        .frame(width: 150, height: 100)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
    
    func hubAirportsView() -> some View {
        VStack {
            HStack {
                Text("\(userData.deliveryHubs.count) Hub airports owned".uppercased())
                    .fontWidth(.expanded)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(userData.deliveryHubs, id: \.uniqueID) { airport in
                        airportItemView(airport.wrappedValue)
                    }
                    Button {
                        withAnimation {
                            showAirportPickerView = false
                        }
                    } label: {
                        VStack {
                            Text("New hub airport")
                                .fontWidth(.expanded)
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .padding(1)
                            Text("$10,000,000")
                                .fontWidth(.condensed)
                            if userData.wrappedValue.accountBalance < 10000000 {
                                Text("Not enough for a new hub")
                                    .fontWidth(.condensed)
                            }
                        }
                        .padding(5)
                        .frame(width: 150, height: 100)
                        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    .buttonStyle(.plain)
                    .disabled(userData.wrappedValue.accountBalance < 10000000)
                    /// To add later in v1.0
                }
            }
        }
    }
}
