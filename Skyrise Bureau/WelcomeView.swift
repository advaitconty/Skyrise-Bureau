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
    @State var viewPage: Int = 3
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
                        TextField("Skyward Collective", text: $newAirlineName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("IATA Code")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("2-letter airline code (e.g., AA, BA, SQ)", text: $airlineIATACode)
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
    
    func pageThreeView() -> some View {
        VStack {
            HStack {
                Text("Select your starter pack")
                    .font(.title)
                    .fontWidth(.expanded)
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
            }
        }
        .padding()
        .frame(minWidth: 700, minHeight: 400)
    }
}

#Preview {
    WelcomeView()
}
