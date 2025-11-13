//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 11/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var showLogo: Bool = true
    @State var showBody: Bool = false
    @State var error: Bool = false
    @State var errorText: String = ""
    @State var newAirlineName: String = ""
    @State var airlineIATACode: String = ""
    @State var userCEOName: String = ""
    @State var viewPage: Int = 1
    @Environment(\.colorScheme) var colorScheme
    @State var carousellItem: Int = 1
    @State var userDataForAddition: UserData = UserData(name: "", airlineName: "", airlineIataCode: "", planes: [], xp: 0, levels: 1, airlineReputation: 0.6, reliabilityIndex: 0.7, fuelDiscountMultiplier: 1, lastFuelPrice: 0.75, pilots: 3, flightAttendents: 3, maintainanceCrew: 3, currentlyHoldingFuel: 1_000_000, maxFuelHoldable: 4_000_000, weeklyPilotSalary: 400, weeklyFlightAttendentSalary: 300, weeklyFlightMaintainanceCrewSalary: 250, pilotHappiness: 0.95, flightAttendentHappiness: 0.95, maintainanceCrewHappiness: 0.95, campaignRunning: false, deliveryHubs: [], accountBalance: 0)
    @State var fleetChoice: Int = 0
    @State var selectedHomeBase: Airport = Airport(
        name: "Dubai International Airport",
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
    
    @State var airlineHomeBase: Airport = Airport(
        name: "Los Angeles International Airport",
        city: "Los Angeles",
        country: "United States",
        iata: "LAX",
        icao: "KLAX",
        region: .northAmerica,
        latitude: 33.9416,
        longitude: -118.4085,
        runwayLength: 3939,
        elevation: 38,
        demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 9.0, businessTravelRatio: 0.72, tourismBoost: 0.88),
        facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4500, gatesAvailable: 130, slotEfficiency: 0.92)
    )
    
    @State var showNextForAirport: Bool = false
    
    func pageOneView() -> some View {
        VStack {
            if showLogo {
                HStack {
                    Image(systemName: "airplane")
                        .font(.title)
                    Text("Welcome to Skyrise Bureau!    ")
                        .font(.title)
                        .fontWidth(.expanded)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.default, completionCriteria: .logicallyComplete) {
                                    showLogo = false
                                } completion: {
                                    withAnimation {
                                        showBody = true
                                    }
                                }
                            }
                        }
                }
                .transition(.push(from: .leading))
            }
            if showBody {
                VStack {
                    Text("Select an airline name to get started!")
                        .font(.title3)
                        .fontWidth(.expanded)
                    
                    HStack {
                        Text("Airline name")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("IndiGo Atlantic", text: $newAirlineName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("Airline CEO")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("Pieters Elbiers", text: $userCEOName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("IATA Code")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("2-letter airline code (e.g., 6E, BA, SQ)", text: $airlineIATACode)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                            .onChange(of: airlineIATACode) { oldValue, newValue in
                                if newValue.count > 2 {
                                    airlineIATACode = String(newValue.prefix(2))
                                }
                            }
                    }
                }
                .transition(.blurReplace)
                .onChange(of: airlineIATACode) {
                    if !newAirlineName.isEmpty && !airlineIATACode.isEmpty && airlineIATACode.count == 2 {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
                .onChange(of: newAirlineName) {
                    if !newAirlineName.isEmpty && !airlineIATACode.isEmpty && airlineIATACode.count == 2 {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                }
            }
            if showNextForAirport {
                Button {
                    withAnimation(.default, completionCriteria: .removed) {
                        viewPage = 2
                    } completion: {
                        print("Done")
                    }
                } label: {
                    Text("Next (select your airport)")
                        .fontWidth(.condensed)
                }
                .transition(.blurReplace)
            }
        }
        .transition(.slide)
    }
    
    func carousell(jet1: String, jet2: String) -> some View {
        VStack {
            if carousellItem == 1 {
                Image(jet1)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 2
                            }
                        }
                    }
            } else if carousellItem == 2 {
                Image(jet2)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 1
                            }
                        }
                    }
            }
        }
        .frame(width: 160, height: 90)
    }
    
    func option(icon: String, name: String, jet1: String, jet2: String, jet1Full: String, jet2Full: String, startingCapital: String, focus: String, option: Int) -> some View {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .font(.title)
                    Text(name)
                        .font(.title)
                        .fontWidth(.expanded)
                }
                carousell(jet1: jet1, jet2: jet2)
                Text(focus)
                    .fontWidth(.condensed)
                HStack {
                    Image(systemName: "airplane")
                    Text("Starting fleet")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                .frame(maxWidth: 160)


                Text(jet1Full)
                    .fontWidth(.condensed)
                Text(jet2Full)
                    .fontWidth(.condensed)
                HStack {
                    Text("Starting capital")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Text(startingCapital)
                        .font(.title2)
                        .fontWidth(.condensed)
                }
            }
            .padding()
            .background(fleetChoice == option ? .blue : (colorScheme == .dark ? Color(red: 18/255, green: 18/255, blue: 18/255) : Color(red: 237/255, green: 237/255, blue: 237/255)))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(width: 350 - 50, height: 300)
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            .onTapGesture {
                withAnimation {
                    fleetChoice = option
                }
            }
    }
    func pageThreeView() -> some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Image(systemName: "backpack")
                    Text("Select your starter pack")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                    if fleetChoice != 0 {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                            Text("Finish setup!")
                                .fontWidth(.condensed)
                        }
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        option(icon: "point.bottomleft.forward.to.point.topright.scurvepath", name: "The Regional Specialist", jet1: "CRJ900", jet2: "E175E2", jet1Full: "2x Bombardier CRJ900", jet2Full: "2x Embraer E175-E2", startingCapital: "$32.5M", focus: "Efficient connections of small, regional airports", option: 1)
                        option(icon: "american.football", name: "The American Workhorse", jet1: "B737-800NG", jet2: "E175E2", jet1Full: "1x Boeing 737-800NG", jet2Full: "2x Embraer E175-E2", startingCapital: "$31.0M", focus: "Operations around a reliable, well-known workhorse.", option: 2)
                        option(icon: "star", name: "The Eurasian Special", jet1: "A319", jet2: "CRJ900", jet1Full: "1x Airbus A319-100", jet2Full: "2x Bombardier CRJ900", startingCapital: "$30.5M", focus: "The perfect fleet for the European and Asian market.", option: 3)
                        option(icon: "person.3", name: "The Domestic", jet1: "A320", jet2: "B737-800NG", jet1Full: "1x Airbus A320-200", jet2Full: "1x Boeing 737-800NG", startingCapital: "$30.5M", focus: "A fleet that maximises profits with modernity.", option: 4)
                        option(icon: "star", name: "The Modern Pioneer", jet1: "E175E2", jet2: "E190E2", jet1Full: "2x Embraer E175-E2", jet2Full: "1x Embraer E190-E2", startingCapital: "$34.0M", focus: "Jets designed around efficiency and modernity.", option: 5)
// TO ADD: 2 MORE OPTIONS
                    }
                }
            }
        }
        .transition(.slide)
    }
    
    var body: some View {
        VStack {
            if viewPage == 1 {
                pageOneView()
            } else if viewPage == 2 {
                AirportPickerView(maxRange: 0, moveOn: Binding(get: {viewPage == 2}, set: { if $0 == true { withAnimation(completionCriteria: .removed) { viewPage = 3 } completion: { print("Completed") } } else { withAnimation { viewPage = 2 } } }), finalAirportSelected: $selectedHomeBase)
                    .transition(.slide)
            } else if viewPage == 3 {
                pageThreeView()
                    .transition(.slide)
            }
        }
        .padding()
        .frame(minWidth: 700, minHeight: 400)
    }
}

#Preview {
    WelcomeView()
}
