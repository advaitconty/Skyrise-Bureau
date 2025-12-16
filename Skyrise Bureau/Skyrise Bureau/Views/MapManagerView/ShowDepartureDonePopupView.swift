//
//  ShowDepartureDonePopupView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import Foundation
import SwiftUI
import Combine

struct DepartureDoneSuccessfullyItemsToShow: Codable {
    var planesTakenOff: [FleetItem]
    var noOfPlanesTakenOff: Int {
        return planesTakenOff.count
    }
    var economyPassenegersServed: Int
    var premiumEconomyPassenegersServed: Int
    var businessPassengersServed: Int
    var firstClassPassengersServed: Int
    
    var maxEconomyPassenegersServed: Int
    var maxPremiumEconomyPassenegersServed: Int
    var maxBusinessPassengersServed: Int
    var maxFirstClassPassengersServed: Int
    
    var moneyMade: Double
}

struct ShowDepartureDonePopupView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showDeparturePopupView: Bool
    @State var count: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let departureDoneSuccessfullyItemsToShow: DepartureDoneSuccessfullyItemsToShow
    
    func listOfDepartedPlaneNames(_ fleetItem: [FleetItem]) -> String {
        var intermediateString: String = ""
        for item in fleetItem {
            intermediateString = "\(item.aircraftname) (\(item.registration)), "
        }
        let finalString = intermediateString.dropLast(2)
        return String(finalString)
    }
    
    func littleSmallBoxThingy(icon: String, item: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(item)
                .fontWidth(.condensed)
                .foregroundStyle(.white)
        }
        .padding(5)
        .background(colorScheme == .dark ? .black.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Text("Successfully departed \(departureDoneSuccessfullyItemsToShow.noOfPlanesTakenOff) plane(s)!")
                    /// TO DO: Research a way that keeps this grammatically correct automatically
                        .font(.title)
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                    Spacer()
                        .onReceive(timer) { _ in
                            count = count + 1
                            if count == 3 {
                                withAnimation {
                                    showDeparturePopupView = false
                                }
                            }
                        }
                }
                
                HStack {
                    Text("Successfully served:")
                        .font(.title3)
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack {
                    littleSmallBoxThingy(icon: "carseat.right", item: "\(departureDoneSuccessfullyItemsToShow.economyPassenegersServed)/\(departureDoneSuccessfullyItemsToShow.maxEconomyPassenegersServed)")
                    littleSmallBoxThingy(icon: "star", item: "\(departureDoneSuccessfullyItemsToShow.premiumEconomyPassenegersServed)/\(departureDoneSuccessfullyItemsToShow.maxPremiumEconomyPassenegersServed)")
                    littleSmallBoxThingy(icon: "carseat.right", item: "\(departureDoneSuccessfullyItemsToShow.economyPassenegersServed)/\(departureDoneSuccessfullyItemsToShow.maxEconomyPassenegersServed)")
                    littleSmallBoxThingy(icon: "carseat.right", item: "\(departureDoneSuccessfullyItemsToShow.economyPassenegersServed)/\(departureDoneSuccessfullyItemsToShow.maxEconomyPassenegersServed)")
                }
            }
        }
        .padding()
        .frame(maxWidth: 400)
        .background(.black.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#Preview {
    let madrid = Airport(
        name: "Adolfo Suárez Madrid-Barajas Airport",
        city: "Madrid",
        country: "Spain",
        iata: "MAD",
        icao: "LEMD",
        region: .europe,
        latitude: 40.4719,
        longitude: -3.5626,
        runwayLength: 4179,
        elevation: 610,
        demand: AirportDemand(passengerDemand: 8.8, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 165000, cargoCapacity: 3000, gatesAvailable: 90, slotEfficiency: 0.88)
    )
    
    let london = Airport(
        name: "London Heathrow Airport",
        city: "London",
        country: "United Kingdom",
        iata: "LHR",
        icao: "EGLL",
        region: .europe,
        latitude: 51.4700,
        longitude: -0.4543,
        runwayLength: 3902,
        elevation: 25,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 8.8, businessTravelRatio: 0.80, tourismBoost: 0.85),
        facilities: AirportFacilities(terminalCapacity: 225000, cargoCapacity: 3800, gatesAvailable: 115, slotEfficiency: 0.93)
    )
    
    let plane1 = FleetItem(
        aircraftID: "IL96-400M",
        aircraftname: "Suka Blyat",
        registration: "VT-SBL",
        hoursFlown: 3,
        assignedRoute: Route(originAirport: madrid, arrivalAirport: london),
        seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
        kilometersTravelledSinceLastMaintainence: 3200,
        currentAirportLocation: london
    )
    
    let plane2 = FleetItem(
        aircraftID: "B777-300ER",
        aircraftname: "Sky Cruiser",
        registration: "N27901",
        hoursFlown: 5,
        assignedRoute: Route(originAirport: london, arrivalAirport: madrid),
        seatingLayout: SeatingConfig(economy: 300, premiumEconomy: 60, business: 40, first: 8),
        kilometersTravelledSinceLastMaintainence: 2800,
        currentAirportLocation: madrid
    )
    
    let testData = DepartureDoneSuccessfullyItemsToShow(
        planesTakenOff: [plane1, plane2],
        economyPassenegersServed: 558,
        premiumEconomyPassenegersServed: 114,
        businessPassengersServed: 68,
        firstClassPassengersServed: 14,
        maxEconomyPassenegersServed: 600,
        maxPremiumEconomyPassenegersServed: 120,
        maxBusinessPassengersServed: 75,
        maxFirstClassPassengersServed: 16, moneyMade: 1000000
    )
    
    ShowDepartureDonePopupView(showDeparturePopupView: .constant(true), departureDoneSuccessfullyItemsToShow: testData)
}
