//
//  DataItems.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import Foundation
import SwiftData

// MARK: - Aircraft Enums

enum AircraftCategory: String, Codable, CaseIterable {
    case extras = "Extras"
    case commuter = "Commuter"
    case regionalJet = "Regional Jets"
    case narrowBody = "Narrow Body"
    case wideBody = "Wide Body"
}

enum AircraftManufacturer: String, Codable {
    case airbus = "Airbus"
    case boeing = "Boeing"
    case embraer = "Embraer"
    case atr = "Aérospatiale"
    case dehavilland = "De Havilland Canada"
    case tupolev = "Tupolev"
    case sukhoi = "Sukhoi"
    case irkut = "Irkut"
    case mcdonnellDouglas = "McDonnell Douglas"
    case ilyushin = "Ilyushin"
    case bombardier = "Bombardier"
}

// MARK: - Aircraft Model

struct Aircraft: Codable, Identifiable, Hashable {
    var id: String { modelCode }
    let modelCode: String
    let name: String
    let manufacturer: AircraftManufacturer
    let category: AircraftCategory
    let description: String
    
    // Performance specs
    let maxRange: Int // in km
    let cruiseSpeed: Int // in km/h
    let maxSeats: Int
    let fuelCapacity: Int // in liters
    let fuelBurnRate: Double // liters per km
    let minRunwayLength: Int // in meters
    
    // Seating configuration
    let defaultSeating: SeatingConfig
    
    // Economics
    let purchasePrice: Double
    let maintenanceCostPerHour: Double
    let yearIntroduced: Int
    let isEndgame: Bool
    
    // Special attributes
    let isSupersonic: Bool
    var customImageHeight: Int = 100
    
    var pilots: Int
    var flightAttendents: Int
}

struct SeatingConfig: Codable, Hashable {
    // Seat space ratios relative to Economy:
    // Premium Economy: ~1.5x
    // Business: ~2.0x
    // First: ~4.0x
    
    var economy: Int
    var premiumEconomy: Int
    var business: Int
    var first: Int
    
    var seatsUsed: Double {
        return Double(economy) + Double(premiumEconomy) * 1.5 + Double(business) * 2.0 + Double(first) * 4.0
    }
}

// MARK: - Airport Enums and Models

enum Region: String, Codable, CaseIterable {
    case asia = "Asia"
    case europe = "Europe"
    case africa = "Africa"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case australiaAndOceania = "Australia and Oceania"
}

struct Airport: Codable, Identifiable, Hashable {
    var id: String { iata }
    let name: String
    let city: String
    let country: String
    let iata: String
    let icao: String
    let region: Region
    let latitude: Double
    let longitude: Double
    let runwayLength: Int // in meters
    let elevation: Int // in meters
    var demand: AirportDemand
    var facilities: AirportFacilities
}

struct AirportDemand: Codable, Hashable {
    var passengerDemand: Double // relative scale, 0.0–10.0
    var cargoDemand: Double
    var businessTravelRatio: Double // 0.0–1.0
    var tourismBoost: Double // influences seasonal spikes
}

struct AirportFacilities: Codable, Hashable {
    var terminalCapacity: Int // passengers per day
    var cargoCapacity: Int // tons per day
    var gatesAvailable: Int
    var slotEfficiency: Double // 0.0–1.0
}


// MARK: - Usage Examples

/*
 Usage in your game:
 
 // Get all aircraft
 let allPlanes = AircraftDatabase.shared.allAircraft
 
 // Get specific aircraft
 if let a380 = AircraftDatabase.shared.aircraft(byCode: "A380-800") {
 print("Found: \(a380.name)")
 }
 
 // Get all narrow body aircraft
 let narrowBodies = AircraftDatabase.shared.aircraft(byCategory: .narrowBody)
 
 // Get all Boeing aircraft
 let boeings = AircraftDatabase.shared.aircraft(byManufacturer: .boeing)
 
 // Get endgame aircraft
 let endgamePlanes = AircraftDatabase.shared.endgameAircraft()
 
 // Get affordable aircraft for player's budget
 let affordable = AircraftDatabase.shared.affordableAircraft(budget: 100_000_000)
 
 // Get aircraft suitable for a specific route
 let suitablePlanes = AircraftDatabase.shared.aircraftForRoute(
 distance: 5000,
 runwayLength: 2500
 )
 
 // When player purchases aircraft, create FleetItem
 if let selectedAircraft = AircraftDatabase.shared.aircraft(byCode: "A320NEO") {
 let newPlane = FleetItem(
 aircraftID: selectedAircraft.modelCode,
 name: selectedAircraft.name,
 registration: "N123AB",
 hoursFlown: 0,
 condition: 100.0,
 isAirborne: false,
 assignedRoute: nil,
 seatingLayout: [
 selectedAircraft.defaultSeating.economy,
 selectedAircraft.defaultSeating.premiumEconomy,
 selectedAircraft.defaultSeating.business,
 selectedAircraft.defaultSeating.first
 ]
 )
 // Add to player's fleet
 }
 */

enum SeatingType: Codable {
    case economy, premiumEconomy, business, firstClass
}

struct Route: Codable {
    var destinationAirport: Airport
    var arrivalAirport: Airport
    var stopoverAirport: Airport?
}

struct FleetItem: Codable, Identifiable {
    var id: UUID = UUID()
    var aircraftID: String
    var aircraftname: String
    var registration: String
    var hoursFlown: Int
    var condition: Double = 1
    var isAirborne: Bool = false
    var estimatedLandingTime: Date?
    var takeoffTime: Date?
    var assignedRoute: Route? = nil
    var seatingLayout: SeatingConfig
    var kilometersTravelledSinceLastMaintainence: Int
    var currentAirportLocation: Airport?
}

@Model
class UserData {
    var name: String
    var airlineName: String
    var airlineIataCode: String
    var planes: [FleetItem]
    var xp: Int = 0
    var levels: Int = 0
    var airlineReputation: Double = 0.5
    var reliabilityIndex: Double = 0.7
    var fuelDiscountMultiplier: Double = 1
    var lastFuelPrice: Double = 0.75 // Starting at this price, lowest will be 0.45, max will be 1.4, based on how much fuel user purchases
    var pilots: Int = 3
    var flightAttendents: Int = 6
    var maintainanceCrew: Int = 4 // 4 for each plane - fixed amount
    var currentlyHoldingFuel: Int = 1_000_000
    var maxFuelHoldable: Int = 4_000_000
    var weeklyPilotSalary: Int = 400
    var weeklyFlightAttendentSalary: Int = 300
    var weeklyFlightMaintainanceCrewSalary: Int = 250
    var pilotHappiness: Double = 0.95
    var flightAttendentHappiness: Double = 0.95
    var maintainanceCrewHappiness: Double = 0.95
    var campaignRunning: Bool = false
    var campaignEffectiveness: Double?
    var deliveryHubs: [Airport]
    var accountBalance: Double
    // Percentage airline improves during campaign. After campaign, airline improves reputation by 1% of their improvement during the campaign
    // airline also looses reputation when their maintainance or happiness drops below 0.7
    
    init(name: String, airlineName: String, airlineIataCode: String, planes: [FleetItem], xp: Int, levels: Int, airlineReputation: Double, reliabilityIndex: Double, fuelDiscountMultiplier: Double, lastFuelPrice: Double, pilots: Int, flightAttendents: Int, maintainanceCrew: Int, currentlyHoldingFuel: Int, maxFuelHoldable: Int, weeklyPilotSalary: Int, weeklyFlightAttendentSalary: Int, weeklyFlightMaintainanceCrewSalary: Int, pilotHappiness: Double, flightAttendentHappiness: Double, maintainanceCrewHappiness: Double, campaignRunning: Bool, campaignEffectiveness: Double? = nil, deliveryHubs: [Airport], accountBalance: Double) {
        self.name = name
        self.airlineName = airlineName
        self.airlineIataCode = airlineIataCode
        self.planes = planes
        self.xp = xp
        self.levels = levels
        self.airlineReputation = airlineReputation
        self.reliabilityIndex = reliabilityIndex
        self.fuelDiscountMultiplier = fuelDiscountMultiplier
        self.lastFuelPrice = lastFuelPrice
        self.pilots = pilots
        self.flightAttendents = flightAttendents
        self.maintainanceCrew = maintainanceCrew
        self.currentlyHoldingFuel = currentlyHoldingFuel
        self.maxFuelHoldable = maxFuelHoldable
        self.weeklyPilotSalary = weeklyPilotSalary
        self.weeklyFlightAttendentSalary = weeklyFlightAttendentSalary
        self.weeklyFlightMaintainanceCrewSalary = weeklyFlightMaintainanceCrewSalary
        self.pilotHappiness = pilotHappiness
        self.flightAttendentHappiness = flightAttendentHappiness
        self.maintainanceCrewHappiness = maintainanceCrewHappiness
        self.campaignRunning = campaignRunning
        self.campaignEffectiveness = campaignEffectiveness
        self.deliveryHubs = deliveryHubs
        self.accountBalance = accountBalance
    }
}

let testUserData = UserData(name: "Advait",
                            airlineName: "IndiGo Atlantic",
                            airlineIataCode: "6E",
                            planes: [
                                FleetItem(aircraftID: "IL96-400M",
                                          aircraftname: "Suka Blyat",
                                          registration: "VT-SBL",
                                          hoursFlown: 3,
                                          assignedRoute: Route(destinationAirport: Airport(
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
                                          ), arrivalAirport: Airport(
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
                                          )),
                                          seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                          kilometersTravelledSinceLastMaintainence: 3200,
                                          currentAirportLocation: Airport(
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
                                          )),
                                FleetItem(aircraftID: "IL96-400M",
                                          aircraftname: "Babushka",
                                          registration: "VT-SBT",
                                          hoursFlown: 3,
                                          seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                          kilometersTravelledSinceLastMaintainence: 3200,
                                          currentAirportLocation: Airport(
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
                                          )),
                                FleetItem(aircraftID: "IL96-400M",
                                          aircraftname: "Karthoshka",
                                          registration: "VT-SVT",
                                          hoursFlown: 3,
                                          seatingLayout: SeatingConfig(economy: 258, premiumEconomy: 54, business: 28, first: 6),
                                          kilometersTravelledSinceLastMaintainence: 3200,
                                          currentAirportLocation: Airport(
                                            name: "Stockholm Arlanda Airport",
                                            city: "Stockholm",
                                            country: "Sweden",
                                            iata: "ARN",
                                            icao: "ESSA",
                                            region: .europe,
                                            latitude: 59.6498,
                                            longitude: 17.9238,
                                            runwayLength: 3301,
                                            elevation: 42,
                                            demand: AirportDemand(passengerDemand: 8.4, cargoDemand: 7.5, businessTravelRatio: 0.70, tourismBoost: 0.78),
                                            facilities: AirportFacilities(terminalCapacity: 155000, cargoCapacity: 2800, gatesAvailable: 75, slotEfficiency: 0.89)
                                          ))
                            ],
                            xp: 32,
                            levels: 2,
                            airlineReputation: 0.8,
                            reliabilityIndex: 0.76,
                            fuelDiscountMultiplier: 0.99,
                            lastFuelPrice: 900,
                            pilots: 9,
                            flightAttendents: 27,
                            maintainanceCrew: 12,
                            currentlyHoldingFuel: 3_000_000,
                            maxFuelHoldable: 5_000_000,
                            weeklyPilotSalary: 500,
                            weeklyFlightAttendentSalary: 400,
                            weeklyFlightMaintainanceCrewSalary: 350,
                            pilotHappiness: 0.98,
                            flightAttendentHappiness: 0.97,
                            maintainanceCrewHappiness: 0.96,
                            campaignRunning: false,
                            deliveryHubs: [
                                Airport(
                                    name: "Stockholm Arlanda Airport",
                                    city: "Stockholm",
                                    country: "Sweden",
                                    iata: "ARN",
                                    icao: "ESSA",
                                    region: .europe,
                                    latitude: 59.6498,
                                    longitude: 17.9238,
                                    runwayLength: 3301,
                                    elevation: 42,
                                    demand: AirportDemand(passengerDemand: 8.4, cargoDemand: 7.5, businessTravelRatio: 0.70, tourismBoost: 0.78),
                                    facilities: AirportFacilities(terminalCapacity: 155000, cargoCapacity: 2800, gatesAvailable: 75, slotEfficiency: 0.89)
                                ),
                                Airport(
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
                                )], accountBalance: 100_000_000)
