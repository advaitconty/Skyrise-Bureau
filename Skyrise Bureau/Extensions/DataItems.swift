//
//  DataItems.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import Foundation
import SwiftData
import _LocationEssentials

// MARK: Calculate Passenger Demand between Airports
struct RoutePassengerDistribution: Codable {
    var firstClass: Int
    var business: Int
    var premiumEconomy: Int
    var economy: Int
    var total: Int {
        return firstClass + business + premiumEconomy + economy
    }
}

/// The special stuff that calculates passenger demand
/// DO NOT TOUCH THIS cus if it works it works
/// ts took 3 days im dying now
extension AirportDatabase {
    func calculatePassengerDistribution(from origin: Airport, to destination: Airport, aircraftCapacity: Int, userData: UserData) -> RoutePassengerDistribution {
        let avergeBusinessRatio = (origin.demand.businessTravelRatio + destination.demand.businessTravelRatio) / 2
        let distance = calculateDistance(from: origin, to: destination)
        let longHaulRoute = distance > 5000
        let averageDemand = (origin.demand.passengerDemand + destination.demand.passengerDemand) / 2
        let averageTourism = (origin.demand.tourismBoost + destination.demand.tourismBoost) / 2
        
        // Base percentages
        var firstPercentage = 0.06
        var businessPercentage = 0.14
        var premiumEconomyPercentage = 0.21
        var economyPercentage = 0.59
        
        if longHaulRoute {
            firstPercentage = 0.05 * avergeBusinessRatio
            businessPercentage = businessPercentage * avergeBusinessRatio + 0.05
            premiumEconomyPercentage = premiumEconomyPercentage + 0.05
            economyPercentage = 1 - firstPercentage - businessPercentage - premiumEconomyPercentage
        } else {
            businessPercentage = 0.10 * avergeBusinessRatio
            premiumEconomyPercentage = 0.08
            economyPercentage = 1 - firstPercentage - businessPercentage - premiumEconomyPercentage
        }
        
        if averageTourism > 0.85 {
            let touristBoost = (averageTourism - 0.85) * 0.5
            economyPercentage = economyPercentage + touristBoost
            premiumEconomyPercentage = premiumEconomyPercentage + touristBoost
            businessPercentage = (1 - touristBoost) * businessPercentage
            firstPercentage = (1 - touristBoost) * firstPercentage
        }
        
        if averageDemand > 9.0 {
            let demandMultiplier = 1.2
            businessPercentage = businessPercentage * demandMultiplier
            firstPercentage = firstPercentage * demandMultiplier
        }
        
        // Normalize percentages FIRST
        let total = firstPercentage + businessPercentage + premiumEconomyPercentage + economyPercentage
        firstPercentage /= total
        businessPercentage /= total
        premiumEconomyPercentage /= total
        economyPercentage /= total
        
        // THEN apply randomization to final seat counts
        let randomMultiplier = Double.random(in: userData.airlineReputation...1.0)
        
        // Calculate seats with randomization
        let first = max(0, Int(Double(aircraftCapacity) * firstPercentage * randomMultiplier))
        let business = max(0, Int(Double(aircraftCapacity) * businessPercentage * randomMultiplier))
        let premiumEconomy = max(0, Int(Double(aircraftCapacity) * premiumEconomyPercentage * randomMultiplier))
        
        // Economy fills the remainder to ensure total = aircraftCapacity
        let economy = max(0, aircraftCapacity - first - business - premiumEconomy)
        
        return RoutePassengerDistribution(firstClass: first, business: business, premiumEconomy: premiumEconomy, economy: economy)
    }
}
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
    var uniqueID: UUID = UUID()
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
    var clLocationCoordinateItemForLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
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

enum SeatingType: Codable {
    case economy, premiumEconomy, business, firstClass
}

struct Route: Codable, Equatable {
    var destinationAirport: Airport
    var arrivalAirport: Airport
    var stopoverAirport: Airport?
}

struct DepartureDoneSuccessfullyItems: Codable {
    var departedSuccessfully: Bool
    var moneyMade: Double?
    var seatsUsedInPlane: Double?
    var seatingConfigOfJet: Double?
}

struct FleetItem: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var aircraftID: String
    var aircraftname: String
    var registration: String
    var hoursFlown: Int
    var condition: Double = 1
    var isAirborne: Bool = false
    var estimatedLandingTime: Date?
    var takeoffTime: Date?
    var landingTime: Date?
    var assignedRoute: Route? = nil
    var seatingLayout: SeatingConfig
    var kilometersTravelledSinceLastMaintainence: Int
    var currentAirportLocation: Airport?
    var inMaintainance: Bool = false
    var endMaintainanceDate: Date? = nil
    var planeLocationInFlight: CLLocationCoordinate2D {
        if isAirborne, let takeoff = takeoffTime, let landing = landingTime, let route = assignedRoute {
            let totalFlightDuration = landing.timeIntervalSince(takeoff)
            let elapsedTime = Date().timeIntervalSince(takeoff)
            let progress = min(max(elapsedTime / totalFlightDuration, 0), 1)
            
            let startLat = route.destinationAirport.latitude
            let startLon = route.destinationAirport.longitude
            let endLat = route.arrivalAirport.latitude
            let endLon = route.arrivalAirport.longitude
            
            let currentLat = startLat + (endLat - startLat) * progress
            let currentLon = startLon + (endLon - startLon) * progress
            
            return CLLocationCoordinate2D(latitude: currentLat, longitude: currentLon)
        } else {
            return currentAirportLocation?.clLocationCoordinateItemForLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    var assignedPricing: SeatingConfig? = nil
    var passengerSeatsUsed: SeatingConfig? = nil
    
    mutating func departJet() -> DepartureDoneSuccessfullyItems {
        /// TO FINISH TMW
        /// Document steps of calculation here
        let planeSelected = AircraftDatabase.shared.allAircraft.first(where: { $0.id == aircraftID })!
        if Double(planeSelected.fuelBurnRate * Double(AirportDatabase.shared.calculateDistance(from: assignedRoute!.destinationAirport, to: assignedRoute!.arrivalAirport))) > Double(planeSelected.maxRange * planeSelected.maxRange) && !self.isAirborne && !(self.condition <= 0.25) {
            isAirborne = true
            takeoffTime = Date()
            landingTime = takeoffTime!.adding(hours: Double(AirportDatabase.shared.calculateDistance(from: assignedRoute!.destinationAirport, to: assignedRoute!.arrivalAirport)) / Double(planeSelected.cruiseSpeed))
            assignedRoute
            return DepartureDoneSuccessfullyItems(departedSuccessfully: true, moneyMade: <#T##Double?#>)
        }
        return false, 0.0
    }
}

/// SwiftData class
/// name --> CEO name, airlineName --> name of the airline, airlineIataCode --> Airline IATA code, that will be used at the start of all
/// flights under that airline, planes [FleetItem] --> Contains a list of the planes
@Model
class UserData {
    var name: String
    var airlineName: String
    var airlineIataCode: String
    var planes: [FleetItem]
    var xp: Int = 0
    var levels: Int = 0
    var airlineReputation: Double = 0.6
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

func amountOfNotDepartedPlanes(_ userData: UserData) -> Int {
    var numberOfunDepartedPlanes: Int = 0
    
    for plane in userData.planes {
        if !plane.isAirborne && plane.assignedRoute != nil {
            numberOfunDepartedPlanes = numberOfunDepartedPlanes + 1
        }
    }
    
    return numberOfunDepartedPlanes
}

/// Test user data
let testUserData = UserData(name: "Advait",
                            airlineName: "IndiGo Atlantic",
                            airlineIataCode: "6E",
                            planes: [
                                FleetItem(aircraftID: "IL96-400M",
                                          aircraftname: "Suka Blyat",
                                          registration: "VT-SBL",
                                          hoursFlown: 3,
                                          assignedRoute: Route(destinationAirport: Airport(
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
                                          ), arrivalAirport: Airport(
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


/// Test user data with planes actively flying
let testUserDataWithFlyingPlanes = UserData(
    name: "Sarah Chen",
    airlineName: "Pacific Wings",
    airlineIataCode: "PW",
    planes: [
        FleetItem(
            aircraftID: "B777-300ER",
            aircraftname: "Sky Voyager",
            registration: "N-PW001",
            hoursFlown: 5420,
            condition: 0.92,
            isAirborne: true,
            estimatedLandingTime: Date().addingTimeInterval(3600 * 2), // Landing in 2 hours
            takeoffTime: Date().addingTimeInterval(-3600 * 4), // Took off 4 hours ago
            landingTime: Date().addingTimeInterval(3600 * 2),
            assignedRoute: Route(
                destinationAirport: Airport(
                    name: "John F. Kennedy International Airport",
                    city: "New York",
                    country: "United States",
                    iata: "JFK",
                    icao: "KJFK",
                    region: .northAmerica,
                    latitude: 40.6413,
                    longitude: -73.7781,
                    runwayLength: 4423,
                    elevation: 4,
                    demand: AirportDemand(passengerDemand: 9.5, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.80),
                    facilities: AirportFacilities(terminalCapacity: 200000, cargoCapacity: 3500, gatesAvailable: 128, slotEfficiency: 0.91)
                ),
                arrivalAirport: Airport(
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
            ),
            seatingLayout: SeatingConfig(economy: 264, premiumEconomy: 48, business: 35, first: 8),
            kilometersTravelledSinceLastMaintainence: 8500,
            currentAirportLocation: Airport(
                name: "John F. Kennedy International Airport",
                city: "New York",
                country: "United States",
                iata: "JFK",
                icao: "KJFK",
                region: .northAmerica,
                latitude: 40.6413,
                longitude: -73.7781,
                runwayLength: 4423,
                elevation: 4,
                demand: AirportDemand(passengerDemand: 9.5, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.80),
                facilities: AirportFacilities(terminalCapacity: 200000, cargoCapacity: 3500, gatesAvailable: 128, slotEfficiency: 0.91)
            )
        ),
        FleetItem(
            aircraftID: "A350-900",
            aircraftname: "Pacific Dream",
            registration: "N-PW002",
            hoursFlown: 3200,
            condition: 0.95,
            isAirborne: true,
            estimatedLandingTime: Date().addingTimeInterval(3600 * 5), // Landing in 5 hours
            takeoffTime: Date().addingTimeInterval(-3600 * 1), // Took off 1 hour ago
            landingTime: Date().addingTimeInterval(3600 * 5),
            assignedRoute: Route(
                destinationAirport: Airport(
                    name: "Singapore Changi Airport",
                    city: "Singapore",
                    country: "Singapore",
                    iata: "SIN",
                    icao: "WSSS",
                    region: .asia,
                    latitude: 1.3644,
                    longitude: 103.9915,
                    runwayLength: 4000,
                    elevation: 7,
                    demand: AirportDemand(passengerDemand: 9.8, cargoDemand: 9.2, businessTravelRatio: 0.72, tourismBoost: 0.90),
                    facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4200, gatesAvailable: 135, slotEfficiency: 0.95)
                ),
                arrivalAirport: Airport(
                    name: "Tokyo Haneda Airport",
                    city: "Tokyo",
                    country: "Japan",
                    iata: "HND",
                    icao: "RJTT",
                    region: .asia,
                    latitude: 35.5494,
                    longitude: 139.7798,
                    runwayLength: 3360,
                    elevation: 11,
                    demand: AirportDemand(passengerDemand: 9.6, cargoDemand: 8.7, businessTravelRatio: 0.78, tourismBoost: 0.82),
                    facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 3600, gatesAvailable: 110, slotEfficiency: 0.94)
                )
            ),
            seatingLayout: SeatingConfig(economy: 280, premiumEconomy: 40, business: 30, first: 6),
            kilometersTravelledSinceLastMaintainence: 5200,
            currentAirportLocation: Airport(
                name: "Singapore Changi Airport",
                city: "Singapore",
                country: "Singapore",
                iata: "SIN",
                icao: "WSSS",
                region: .asia,
                latitude: 1.3644,
                longitude: 103.9915,
                runwayLength: 4000,
                elevation: 7,
                demand: AirportDemand(passengerDemand: 9.8, cargoDemand: 9.2, businessTravelRatio: 0.72, tourismBoost: 0.90),
                facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4200, gatesAvailable: 135, slotEfficiency: 0.95)
            )
        ),
        FleetItem(
            aircraftID: "B787-9",
            aircraftname: "Ocean Breeze",
            registration: "N-PW003",
            hoursFlown: 4100,
            condition: 0.88,
            isAirborne: true,
            estimatedLandingTime: Date().addingTimeInterval(3600 * 3.5), // Landing in 3.5 hours
            takeoffTime: Date().addingTimeInterval(-3600 * 2.5), // Took off 2.5 hours ago
            landingTime: Date().addingTimeInterval(3600 * 3.5),
            assignedRoute: Route(
                destinationAirport: Airport(
                    name: "Los Angeles International Airport",
                    city: "Los Angeles",
                    country: "United States",
                    iata: "LAX",
                    icao: "KLAX",
                    region: .northAmerica,
                    latitude: 33.9416,
                    longitude: -118.4085,
                    runwayLength: 3685,
                    elevation: 38,
                    demand: AirportDemand(passengerDemand: 9.4, cargoDemand: 8.3, businessTravelRatio: 0.68, tourismBoost: 0.92),
                    facilities: AirportFacilities(terminalCapacity: 220000, cargoCapacity: 3400, gatesAvailable: 135, slotEfficiency: 0.90)
                ),
                arrivalAirport: Airport(
                    name: "Sydney Kingsford Smith Airport",
                    city: "Sydney",
                    country: "Australia",
                    iata: "SYD",
                    icao: "YSSY",
                    region: .australiaAndOceania,
                    latitude: -33.9399,
                    longitude: 151.1753,
                    runwayLength: 3962,
                    elevation: 6,
                    demand: AirportDemand(passengerDemand: 9.0, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.95),
                    facilities: AirportFacilities(terminalCapacity: 180000, cargoCapacity: 2900, gatesAvailable: 95, slotEfficiency: 0.88)
                )
            ),
            seatingLayout: SeatingConfig(economy: 246, premiumEconomy: 36, business: 28, first: 0),
            kilometersTravelledSinceLastMaintainence: 6800,
            currentAirportLocation: Airport(
                name: "Los Angeles International Airport",
                city: "Los Angeles",
                country: "United States",
                iata: "LAX",
                icao: "KLAX",
                region: .northAmerica,
                latitude: 33.9416,
                longitude: -118.4085,
                runwayLength: 3685,
                elevation: 38,
                demand: AirportDemand(passengerDemand: 9.4, cargoDemand: 8.3, businessTravelRatio: 0.68, tourismBoost: 0.92),
                facilities: AirportFacilities(terminalCapacity: 220000, cargoCapacity: 3400, gatesAvailable: 135, slotEfficiency: 0.90)
            )
        ),
        FleetItem(
            aircraftID: "A320neo",
            aircraftname: "Island Hopper",
            registration: "N-PW004",
            hoursFlown: 1850,
            condition: 0.97,
            isAirborne: false,
            assignedRoute: Route(
                destinationAirport: Airport(
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
                    demand: AirportDemand(passengerDemand: 9.7, cargoDemand: 9.0, businessTravelRatio: 0.82, tourismBoost: 0.88),
                    facilities: AirportFacilities(terminalCapacity: 260000, cargoCapacity: 4500, gatesAvailable: 150, slotEfficiency: 0.92)
                ),
                arrivalAirport: Airport(
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
            ),
            seatingLayout: SeatingConfig(economy: 150, premiumEconomy: 24, business: 12, first: 0),
            kilometersTravelledSinceLastMaintainence: 2400,
            currentAirportLocation: Airport(
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
                demand: AirportDemand(passengerDemand: 9.7, cargoDemand: 9.0, businessTravelRatio: 0.82, tourismBoost: 0.88),
                facilities: AirportFacilities(terminalCapacity: 260000, cargoCapacity: 4500, gatesAvailable: 150, slotEfficiency: 0.92)
            )
        )
    ],
    xp: 4500,
    levels: 12,
    airlineReputation: 0.92,
    reliabilityIndex: 0.89,
    fuelDiscountMultiplier: 0.85,
    lastFuelPrice: 0.68,
    pilots: 16,
    flightAttendents: 48,
    maintainanceCrew: 16,
    currentlyHoldingFuel: 8_500_000,
    maxFuelHoldable: 12_000_000,
    weeklyPilotSalary: 650,
    weeklyFlightAttendentSalary: 450,
    weeklyFlightMaintainanceCrewSalary: 400,
    pilotHappiness: 0.93,
    flightAttendentHappiness: 0.91,
    maintainanceCrewHappiness: 0.94,
    campaignRunning: true,
    campaignEffectiveness: 0.15,
    deliveryHubs: [
        Airport(
            name: "Singapore Changi Airport",
            city: "Singapore",
            country: "Singapore",
            iata: "SIN",
            icao: "WSSS",
            region: .asia,
            latitude: 1.3644,
            longitude: 103.9915,
            runwayLength: 4000,
            elevation: 7,
            demand: AirportDemand(passengerDemand: 9.8, cargoDemand: 9.2, businessTravelRatio: 0.72, tourismBoost: 0.90),
            facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4200, gatesAvailable: 135, slotEfficiency: 0.95)
        ),
        Airport(
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
            demand: AirportDemand(passengerDemand: 9.7, cargoDemand: 9.0, businessTravelRatio: 0.82, tourismBoost: 0.88),
            facilities: AirportFacilities(terminalCapacity: 260000, cargoCapacity: 4500, gatesAvailable: 150, slotEfficiency: 0.92)
        ),
        Airport(
            name: "Los Angeles International Airport",
            city: "Los Angeles",
            country: "United States",
            iata: "LAX",
            icao: "KLAX",
            region: .northAmerica,
            latitude: 33.9416,
            longitude: -118.4085,
            runwayLength: 3685,
            elevation: 38,
            demand: AirportDemand(passengerDemand: 9.4, cargoDemand: 8.3, businessTravelRatio: 0.68, tourismBoost: 0.92),
            facilities: AirportFacilities(terminalCapacity: 220000, cargoCapacity: 3400, gatesAvailable: 135, slotEfficiency: 0.90)
        )
    ],
    accountBalance: 285_000_000
)


/// Exists for the sole purpose of maps
/// Selects the type of the airport that needs to be changed
enum AirportType: Codable {
    case departure, arrival, stopover
}
