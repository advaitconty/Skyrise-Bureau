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
                            showAirportPickerView = true
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
                    .onChange(of: showAirportPickerView) { oldValue, newValue in
                        if oldValue && !newValue && AirportDatabase.shared.allAirports.contains(where: {selectedAirport.name == $0.name}) {
                            withAnimation {
                                userData.wrappedValue.deliveryHubs.append(selectedAirport)
                                userData.wrappedValue.accountBalance -= 10000000
                            }
                            selectedAirport = Airport(
                                name: "Soote",
                                city: "Dubai",
                                country: "United Arab Emirates",
                                iata: "DXB",
                                icao: "OMDB",
                                region: .asia,
                                latitude: 25.2532,
                                longitude: 55.3657,
                                runwayLength: 4000,
                                elevation: 19,
                                demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.78, tourismBoost: 0.88),
                                facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 4800, gatesAvailable: 120, slotEfficiency: 0.94)
                            )
                        }
                    }
                    /// To add later in v1.0
                }
            }
        }
    }
}
