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
    
    var total: Int {
        economy + premiumEconomy + business + first
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
    var isAirbone: Bool = false
    var assignedRoute: Route? = nil
    var seatingLayout: [Int]
    /// Index 0 will be economy, and so on.............
    var kilometersTravelledSinceLastMaintainence: Int
}

@Model
class UserData {
    var name: String
    var planes: [FleetItem]
    var xp: Int = 0
    var levels: Int = 0
    var airlineReputation: Double = 0.5
    var reliabilityIndex: Int = 5
    var fuelDiscountMultiplier: Double = 1
    var lastFuelPrice: Double = 0.75 // Starting at this price, lowest will be 0.45, max will be 1.4, based on how much fuel user purchases
    var pilots: Int = 3
    var flightAttendents: Int = 6
    
    init(name: String, planes: [FleetItem], xp: Int, levels: Int, airlineReputation: Double, reliabilityIndex: Int, fuelDiscountMultiplier: Double, lastFuelPrice: Double, pilots: Int, flightAttendents: Int) {
        self.name = name
        self.planes = planes
        self.xp = xp
        self.levels = levels
        self.airlineReputation = airlineReputation
        self.reliabilityIndex = reliabilityIndex
        self.fuelDiscountMultiplier = fuelDiscountMultiplier
        self.lastFuelPrice = lastFuelPrice
        self.pilots = pilots
        self.flightAttendents = flightAttendents
    }
}
