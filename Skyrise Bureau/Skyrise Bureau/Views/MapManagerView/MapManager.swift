//
//  MapManager.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import MapKit
import SwiftUI
import Combine

class Clock: ObservableObject {
    @Published var now = Date()
    private var timer = Timer()
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.now = Date()
        }
    }
}

struct MapManagerView: View {
    @State var airportSelector: Bool = false
    @State var openFuelWindow: Bool = false
    @Namespace var mapScope
    @Namespace var namespace
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @State var temporarilySelectedAirportToGetMoreInformationOn: Airport? = nil
    @State var selectedPlane: FleetItem? = nil
    @Environment(\.colorScheme) var colorScheme
    @Binding var userData: UserData
    @State var sidebarWidth: Float = 300
    @State var selectedJet: Int? = nil
    @State var showSidebar: Bool = true
    @StateObject var clock = Clock()
    @State var openSettings: Bool = false
    @State var openUserUpgradeView: Bool = false
    @State var takeoffItems: DepartureDoneSuccessfullyItemsToShow? = nil
    @State var showTakeoffPopup: Bool = false
    @State var openShopView: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                // map item
                ZStack(alignment: .bottomLeading) {
                    Map {
                        ForEach(AirportDatabase.shared.allAirports, id: \.id) { airport in
                            airportAnnotation(airport)
                        }
                        
                        ForEach(userData.planes.compactMap { plane -> (FleetItem, Airport)? in
                            guard let location = plane.currentAirportLocation else { return nil }
                            return (plane, location)
                        }, id: \.0.id) { plane, location in
                            aircraftAnnotation(plane, location: location)
                            if let route = plane.assignedRoute {
                                aircraftRouteAnnotation(route)
                            }
                        }
                    }
                    .onAppear {
                        print("Loaded view")
                    }
                    .mapStyle(mapType)
                    .mapControls {
                        MapPitchToggle(scope: mapScope)
                        MapCompass(scope: mapScope)
                        MapScaleView(scope: mapScope)
                    }
                }
                
                HStack(spacing: 0) {
                    VStack {
                        HStack(spacing: 0) {
                            if selectedJet == nil {
                                VStack {
                                    HStack {
                                        if #available(iOS 26.0, *) {
                                            (Text(userData.airlineName)
                                                .fontWidth(.expanded)
                                                .font(.title)
                                             +
                                             Text("\nmanaged by \(userData.name)")
                                                .fontWidth(.condensed))
                                            .containerCornerOffset(.leading, sizeToFit: true)
                                        } else {
                                            (Text(userData.airlineName)
                                                .fontWidth(.expanded)
                                                .font(.title)
                                             +
                                             Text("\nmanaged by \(userData.name)")
                                                .fontWidth(.condensed))                                }
                                        Spacer()
                                    }
                                    
                                    ScrollView {
                                        if amountOfNotDepartedPlanes(userData) > 0 {
                                            Button {
                                                var jetsDepartedSuccessfully: [DepartureDoneSuccessfullyItems] = []
                                                for (index, plane) in userData.planes.enumerated() {
                                                    if !plane.isAirborne {
                                                        var attempt = userData.planes[index].departJet($userData)
                                                        if attempt.departedSuccessfully {
                                                            attempt.planeInfo = userData.planes[index]
                                                            jetsDepartedSuccessfully.append(attempt)
                                                        }
                                                    }
                                                }
                                                print(jetsDepartedSuccessfully)
                                                var planesTakenOff: [FleetItem] = []
                                                var economyPassengersServed: Int = 0
                                                var premiumEconomyPassengersServed: Int = 0
                                                var businessPassengersServed: Int = 0
                                                var firstPassengersServed: Int = 0
                                                
                                                var maxEconomyPassengersServed: Int = 0
                                                var maxPremiumEconomyPassengersServed: Int = 0
                                                var maxBusinessPassengersServed: Int = 0
                                                var maxFirstPassengersServed: Int = 0
                                                
                                                var totalMoneyMade: Double = 0
                                                
                                                for jetDepartedSuccessfully in jetsDepartedSuccessfully {
                                                    planesTakenOff.append(jetDepartedSuccessfully.planeInfo ?? FleetItem(aircraftID: "somethong", aircraftname: "goasngo", registration: "gaogns", hoursFlown: 0, seatingLayout: SeatingConfig(economy: 4, premiumEconomy: 41, business: 414, first: 41), kilometersTravelledSinceLastMaintainence: 4))
                                                    economyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.economy
                                                    premiumEconomyPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.premiumEconomy
                                                    businessPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.business
                                                    firstPassengersServed += jetDepartedSuccessfully.seatsUsedInPlane!.first
                                                    maxEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.economy
                                                    maxPremiumEconomyPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.premiumEconomy
                                                    maxBusinessPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.business
                                                    maxFirstPassengersServed += jetDepartedSuccessfully.seatingConfigOfJet!.first
                                                    totalMoneyMade += jetDepartedSuccessfully.moneyMade!
                                                }
                                                
                                                takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: planesTakenOff, economyPassenegersServed: economyPassengersServed, premiumEconomyPassenegersServed: premiumEconomyPassengersServed, businessPassengersServed: businessPassengersServed, firstClassPassengersServed: firstPassengersServed, maxEconomyPassenegersServed: maxEconomyPassengersServed, maxPremiumEconomyPassenegersServed: maxPremiumEconomyPassengersServed, maxBusinessPassengersServed: maxBusinessPassengersServed, maxFirstClassPassengersServed: maxFirstPassengersServed, moneyMade: totalMoneyMade)
                                                withAnimation {
                                                    showTakeoffPopup = true
                                                }
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Text("Depart all (\(amountOfNotDepartedPlanes(userData)) to depart)")
                                                        .fontWidth(.condensed)
                                                    Spacer()
                                                }
                                            }
                                            .adaptiveProminentButtonStyle()
                                            .hoverEffect()
                                        }
                                        
                                        ForEach(userData.planes, id: \.id) { plane in
                                            Button {
                                                withAnimation {
                                                    selectedJet = userData.planes.firstIndex(where: { $0.id == plane.id })!
                                                }
                                            } label: {
                                                planeItemView(plane)
                                            }
                                            .buttonStyle(.plain)
                                            .hoverEffect()
                                        }
                                    }
                                    
                                    Spacer()
                                    /// For the extras
                                    VStack {
                                        ProgressView(value: userData.progressToNextXPLevel) {
                                            HStack {
                                                Text("Level \(userData.levels)")
                                                    .fontWidth(.condensed)
                                                Spacer()
                                                Text("\(userData.xpRequiredForNextXPLevel) XP to next level")
                                                    .fontWidth(.condensed)
                                            }
                                        }
                                        HStack {
                                            Text("Balance: $\(userData.accountBalance.withCommas)")
                                                .fontWidth(.condensed)
                                            Spacer()
                                            Text("Reputation: \((userData.airlineReputation * 100).withCommas)%")
                                                .fontWidth(.condensed)
                                        }
                                        
                                        HStack {
                                            if #available(iOS 26.0, *) {
                                                Button {
                                                    openFuelWindow = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "fuelpump")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    print("Open")
                                                    openUserUpgradeView = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "person.text.rectangle")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    openShopView = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "cart")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                                
                                                Button {
                                                    print("SUMMON")
                                                    openSettings = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "gearshape.2")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.glass)
                                                .hoverEffect()
                                            } else {
                                                Button {
                                                    openFuelWindow = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "fuelpump")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    print("Open")
                                                    openUserUpgradeView = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "person.text.rectangle")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    openShopView = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "cart")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                                
                                                Button {
                                                    openSettings = true
                                                } label: {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "gearshape.2")
                                                        Spacer()
                                                    }
                                                }
                                                .buttonStyle(.bordered)
                                                .hoverEffect()
                                            }
                                        }
                                        
                                        // Statistics since toolbar hidden
                                        HStack {
                                            Text(clock.now.formatted(.dateTime.hour().minute()))
                                                .fontWidth(.expanded)
                                            Spacer()
                                            Text(clock.now, style: .date)
                                                .fontWidth(.compressed)
                                        }
                                    }
                                }
                                //                            .transition(.slide)
                                .transition(.move(edge: .leading))
                            } else {
                                selectedJetView()
                                    .transition(.move(edge: .trailing))
                            }
                            
                        }
                        .padding()
                        .frame(width: CGFloat(sidebarWidth + 10), height: reader.size.height - 30)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                    Rectangle()
                        .frame(width: 10)
                        .foregroundStyle(.clear)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged { value in
                            let newWidth = CGFloat(self.sidebarWidth) + value.translation.width
                            self.sidebarWidth = Float(CGFloat(min(500, max(250, newWidth))))
                        })
                        .onChange(of: reader.size.width) {
                            if sidebarWidth > Float(reader.size.width) - 40 {
                                sidebarWidth = Float(reader.size.width) - 40
                            }
                        }
                        .onChange(of: sidebarWidth) {
                            if sidebarWidth > Float(reader.size.width) - 40 {
                                sidebarWidth = Float(reader.size.width) - 40
                            }
                        }
                }
                .padding()
            }
            
            if showTakeoffPopup {
                ShowDepartureDonePopupView(showDeparturePopupView: $showTakeoffPopup, departureDoneSuccessfullyItemsToShow: takeoffItems!)
            }
        }
        .statusBarHidden(true)
        .ignoresSafeArea()
        .sheet(isPresented: $openSettings) {
            SettingsView(userData: $userData)
        }
        .fullScreenCover(isPresented: $airportSelector) {
            AirportPickerView(airportSelected: Binding {
                return userData.planes[selectedJet!].assignedRoute!.arrivalAirport
            } set: {
                userData.planes[selectedJet!].assignedRoute!.arrivalAirport = $0
            }, airportSelectionText: "Select your destination airport",
                              userData: userData,
                              maxRange: AircraftDatabase.shared.allAircraft.first(where: { $0.id == $userData.wrappedValue.planes[selectedJet!].aircraftID })!.maxRange,
                              startAirport: userData.planes[selectedJet!].currentAirportLocation,
                              finishedPickingScreen: Binding {
                return !openSettings
            } set: {
                print($0)
                if $0 {
                    print("check")
                    openSettings = false
                }
            })
        }
        .fullScreenCover(isPresented: $openUserUpgradeView) {
            UserUpgradeView(userData: $userData)
                .onAppear {
                    print("Open")
                }
        }
        .fullScreenCover(isPresented: $openFuelWindow) {
            FuelPriceView(userData: $userData)
        }
        .fullScreenCover(isPresented: $openShopView) {
            ShopView(userData: $userData)
        }
    }
}

#Preview {
    MapManagerView(userData: .constant(testUserDataWithFlyingPlanes))
}
