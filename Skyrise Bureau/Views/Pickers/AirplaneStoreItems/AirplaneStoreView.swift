import SwiftUI
import AppKit
import CompactSlider
import SwiftData

struct AirplaneStoreView: View {
    @Query var swiftDataUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            swiftDataUserData.first ?? testUserData
        } set: { value in
            if let item = swiftDataUserData.first {
                item.planes = value.planes
                item.deliveryHubs = value.deliveryHubs
                item.airlineIataCode = value.airlineIataCode
                item.airlineName = value.airlineName
                item.name = value.name
                item.accountBalance = value.accountBalance
                item.airlineReputation = value.airlineReputation
                item.campaignEffectiveness = value.campaignEffectiveness
                item.campaignRunning = value.campaignRunning
                item.currentlyHoldingFuel = value.currentlyHoldingFuel
                item.flightAttendentHappiness = value.flightAttendentHappiness
                item.flightAttendents = value.flightAttendents
                item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                item.lastFuelPrice = value.lastFuelPrice
                item.levels = value.levels
                item.maintainanceCrew = value.maintainanceCrew
                item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                item.maxFuelHoldable = value.maxFuelHoldable
                item.pilotHappiness = value.pilotHappiness
                item.pilots = value.pilots
                item.pilotHappiness = value.pilotHappiness
                item.xp = value.xp
                
                try? modelContext.save()
            }
        }
    }
    @State var searchTerm: String = ""
    @State var selectedType: String? = nil
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius = 10.0
    @State var showPlaneStats: Aircraft? = nil
    @State var showPlane: Bool = false
    @State var preferedSeatingConfig: SeatingConfig = SeatingConfig(economy: 0, premiumEconomy: 0, business: 0, first: 0)
    @State var showContextScreen: Bool = false
    @State var showNotAllSeatsFilled: Bool = false
    @State var showAllSeatsFileld: Bool = false
    @State var registration: String = "SB-"
    @State var aircraftName: String = "Horizon Jet"
    @State var airportToDeliverPlaneTo: Airport = Airport(
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
    
    var filteredPlanes: [Aircraft] {
        AircraftDatabase.shared.allAircraft.filter { plane in
            let matchesSearch = searchTerm.isEmpty || plane.name.localizedCaseInsensitiveContains(searchTerm) || plane.manufacturer.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            let matchesType = selectedType == nil
            
            return matchesSearch && matchesType
        }
    }
        
    var body: some View {
        if showPlane == false {
            shopView(userData.wrappedValue)
                .transition(.move(edge: .leading))
        } else {
            if let plane = showPlaneStats {
                planeStatsView(plane: plane)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
