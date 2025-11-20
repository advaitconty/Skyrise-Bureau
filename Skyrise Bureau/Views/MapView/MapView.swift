//
//  MapView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Namespace var mapScope
    @Namespace var namespace
    @State var showMapSelector: Bool = false
    @State var mapType: MapStyle = .standard(elevation: .realistic, pointsOfInterest: .all)
    @AppStorage("mapType") var savedMapType: String = "Satelite"
    @Environment(\.colorScheme) var colorScheme
    @State var showSidebar: Bool = true
    @State var sidebarWidth: Int = 200
    @State var cameraPosition: MapCameraPosition = .automatic
    @Binding var userData: UserData
    @State var selectedPlane: FleetItem? = nil
    @State var showAirportPicker: Bool = false
    @State var userDoneSelectedAirport: Bool = false
    @State var aircraftDatabase: AircraftDatabase = AircraftDatabase()
    @State var temporarilySelectedAirportHolderVariableThingamajik: Airport = Airport(
        name: "Toronto Pearson International Airport",
        city: "Toronto",
        country: "Canada",
        iata: "YYZ",
        icao: "CYYZ",
        region: .northAmerica,
        latitude: 43.6777,
        longitude: -79.6248,
        runwayLength: 3389,
        elevation: 173,
        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
    )
    @State var temporarilySelectedAirportToGetMoreInformationOn: Airport? = nil
    @State var showTemporarilySelectedAirportToGetMoreInformationOnPopUp: Bool = false
    @State var planeFleetItemToChangeIndex: Int = 0
    @State var showTakeoffPopup: Bool = false
    @State var takeoffItems: DepartureDoneSuccessfullyItems = DepartureDoneSuccessfullyItems(departedSuccessfully: false, moneyMade: nil, seatsUsedInPlane: nil, seatingConfigOfJet: nil)
    /// Temporarily held like this
    @State var airportType:  AirportType = .arrival
    @State var maxRangeOfSelectedJet: Int = 0
    @State var currentLocationOfPlane: Airport = Airport(
        name: "Toronto Pearson International Airport",
        city: "Toronto",
        country: "Canada",
        iata: "YYZ",
        icao: "CYYZ",
        region: .northAmerica,
        latitude: 43.6777,
        longitude: -79.6248,
        runwayLength: 3389,
        elevation: 173,
        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
    )
    @Environment(\.openWindow) var openWindow

    var body: some View {
        VStack {
            if !showAirportPicker {
                ZStack {
                    regularMapView()
                        .transition(.move(edge: .top))
                    
                    if showTakeoffPopup {
                        VStack {
                            Text("Plane")
                        }
                        .padding()
                        .transition(.blurReplace)
                        .foregroundStyle(.black.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                }
            } else {
                AirportPickerView(maxRange: maxRangeOfSelectedJet, startAirport: currentLocationOfPlane, moveOn: $userDoneSelectedAirport, finalAirportSelected: $temporarilySelectedAirportHolderVariableThingamajik)
                    .transition(.move(edge: .top))
                    .padding()
            }
        }
        .onChange(of: userDoneSelectedAirport) { originalValue, newValue in
            if newValue {
                if userData.planes[planeFleetItemToChangeIndex].assignedRoute == nil {
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute = Route(originAirport: Airport(
                        name: "Toronto Pearson International Airport",
                        city: "Toronto",
                        country: "Canada",
                        iata: "YYZ",
                        icao: "CYYZ",
                        region: .northAmerica,
                        latitude: 43.6777,
                        longitude: -79.6248,
                        runwayLength: 3389,
                        elevation: 173,
                        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
                        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
                    ), arrivalAirport: Airport(
                        name: "Toronto Pearson International Airport",
                        city: "Toronto",
                        country: "Canada",
                        iata: "YYZ",
                        icao: "CYYZ",
                        region: .northAmerica,
                        latitude: 43.6777,
                        longitude: -79.6248,
                        runwayLength: 3389,
                        elevation: 173,
                        demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.78),
                        facilities: AirportFacilities(terminalCapacity: 195000, cargoCapacity: 3800, gatesAvailable: 105, slotEfficiency: 0.90)
                    ))
                }
                switch airportType {
                case .departure:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.originAirport = temporarilySelectedAirportHolderVariableThingamajik
                case .arrival:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.arrivalAirport = temporarilySelectedAirportHolderVariableThingamajik
                case .stopover:
                    userData.planes[planeFleetItemToChangeIndex].assignedRoute?.stopoverAirport = temporarilySelectedAirportHolderVariableThingamajik
                }
                userData.planes[planeFleetItemToChangeIndex].assignedRoute?.originAirport = userData.planes[planeFleetItemToChangeIndex].currentAirportLocation!
                print(userData.planes[planeFleetItemToChangeIndex].assignedRoute)
                userDoneSelectedAirport = false
            }
            withAnimation {
                showAirportPicker = false
            }
        }
    }
}

#Preview {
    MapView(userData: .constant(testUserData))
}
