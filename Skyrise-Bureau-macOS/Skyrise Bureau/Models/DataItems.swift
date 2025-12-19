//
//  DataItems.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import Foundation
import SwiftData
import _LocationEssentials
import SwiftUI

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
    
    var totalSeatsOnBoardPlane: Int {
        return economy + premiumEconomy + business + first
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

struct Airport: Codable, Identifiable, Hashable, Equatable {
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
    func reportCorrectCodeForUserData(_ userData: UserData) -> String {
        switch userData.preferedAirlineCodeType {
        case .iata:
            return iata
        case .icao:
            return icao
        }
    }
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.icao == rhs.icao
    }
}

struct PricingConfig: Codable, Hashable {
    var economy: Double
    var premiumEconomy: Double
    var business: Double
    var first: Double
    
    var seatsUsed: Double {
        return Double(economy) + Double(premiumEconomy) * 1.5 + Double(business) * 2.0 + Double(first) * 4.0
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
    var originAirport: Airport
    var arrivalAirport: Airport
    var stopoverAirport: Airport?
}

struct DepartureDoneSuccessfullyItems: Codable {
    var departedSuccessfully: Bool
    var moneyMade: Double?
    var seatsUsedInPlane: SeatingConfig?
    var seatingConfigOfJet: SeatingConfig?
    var planeInfo: FleetItem?
}

struct FleetItem: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var aircraftID: String
    var aircraftname: String
    var registration: String
    var hoursFlown: Double
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
    var lastHoursOfPlaneDuringMaintainance: Double = 0
    var planeLocationInFlight: CLLocationCoordinate2D {
        if isAirborne, let takeoff = takeoffTime, let landing = landingTime, let route = assignedRoute {
            let totalFlightDuration = landing.timeIntervalSince(takeoff)
            let elapsedTime = Date().timeIntervalSince(takeoff)
            let progress = min(max(elapsedTime / totalFlightDuration, 0), 1)
                
            let startLat = route.originAirport.latitude
            let startLon = route.originAirport.longitude
            let endLat = route.arrivalAirport.latitude
            let endLon = route.arrivalAirport.longitude
            
            let currentLat = startLat + (endLat - startLat) * progress
            let currentLon = startLon + (endLon - startLon) * progress
            
            return CLLocationCoordinate2D(latitude: currentLat, longitude: currentLon)
        } else {
            return currentAirportLocation?.clLocationCoordinateItemForLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    var assignedPricing: PricingConfig = PricingConfig(economy: 100, premiumEconomy: 150, business: 250, first: 400)
    var passengerSeatsUsed: SeatingConfig? = nil
    func timeTakenForJetToReturn(_ currentDate: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .dropAll
        return formatter.string(from: currentDate, to: landingTime!)!
        
    }
    
    func timeTakenForJetToGetOutOfMaintainance(_ currentDate: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .dropAll
        return formatter.string(from: currentDate, to: endMaintainanceDate!)!
    }
    
    mutating func markJetAsMaintainanceDone() {
        inMaintainance = false
        endMaintainanceDate = nil
    }
    
    mutating func departJet(_ userDataProvided: Binding<UserData>) -> DepartureDoneSuccessfullyItems {
        /// Steps for calculation of departure
        /// 1. Get route passenger distribution
        /// 2. Apply multiplier for increasing/decreasing demand based on:
        ///    - How expensive the tickets are
        ///    - The reputation of the airline (price per km based on this statistic)
        /// 3. Return DepartureDoneSuccessfullyItems
        
        let pricing = assignedPricing
        guard let route = assignedRoute, !isAirborne, condition > 0.25 else {
            return DepartureDoneSuccessfullyItems(departedSuccessfully: false, moneyMade: nil, seatsUsedInPlane: nil, seatingConfigOfJet: nil)
        }
        print("conditions 1 matched")
        let planeSelected = AircraftDatabase.shared.allAircraft.first(where: { $0.id == aircraftID })!
        let db = AirportDatabase()
        let distance = db.calculateDistance(from: route.originAirport, to: route.arrivalAirport)
        let fuelRequired = Double(planeSelected.fuelBurnRate) * Double(distance)
        if userDataProvided.wrappedValue.currentlyHoldingFuel - Int(fuelRequired) < 0 {
            return DepartureDoneSuccessfullyItems(departedSuccessfully: false, moneyMade: nil, seatsUsedInPlane: nil, seatingConfigOfJet: nil)
        }
        print("conditions 2 matched")

        // Check if plane has enough range
        guard fuelRequired <= Double(planeSelected.fuelCapacity) else {
            return DepartureDoneSuccessfullyItems(departedSuccessfully: false, moneyMade: nil, seatsUsedInPlane: nil, seatingConfigOfJet: nil)
        }
        print("conditions 3 matched")

        // Calculate base demand
        let baseDemand = db.calculatePassengerDistribution(
            from: route.originAirport,
            to: route.arrivalAirport,
            aircraftCapacity: seatingLayout.totalSeatsOnBoardPlane,
            userData: userDataProvided.wrappedValue
        )
        
        // Calculate reasonable market pricing for this route
        let reasonablePricingForAirline = SeatingConfig(
            economy: Int(predictorModel.predictPricePerKM(rating: userDataProvided.wrappedValue.airlineReputation, seatClass: .economy) * Double(distance)),
            premiumEconomy: Int(predictorModel.predictPricePerKM(rating: userDataProvided.wrappedValue.airlineReputation, seatClass: .premiumEconomy) * Double(distance)),
            business: Int(predictorModel.predictPricePerKM(rating: userDataProvided.wrappedValue.airlineReputation, seatClass: .business) * Double(distance)),
            first: Int(predictorModel.predictPricePerKM(rating: userDataProvided.wrappedValue.airlineReputation, seatClass: .first) * Double(distance))
        )
        
        // Calculate demand multipliers based on pricing for each class
        let economyMultiplier = calculatePricingMultiplier(
            userPrice: Double(pricing.economy),
            marketPrice: Double(reasonablePricingForAirline.economy),
            elasticity: 1.5
        )
        let premiumMultiplier = calculatePricingMultiplier(
            userPrice: Double(pricing.premiumEconomy),
            marketPrice: Double(reasonablePricingForAirline.premiumEconomy),
            elasticity: 1.3
        )
        let businessMultiplier = calculatePricingMultiplier(
            userPrice: Double(pricing.business),
            marketPrice: Double(reasonablePricingForAirline.business),
            elasticity: 1.0
        )
        let firstMultiplier = calculatePricingMultiplier(
            userPrice: Double(pricing.first),
            marketPrice: Double(reasonablePricingForAirline.first),
            elasticity: 0.8
        )
        
        // Apply multipliers to base demand
        let adjustedDemand = RoutePassengerDistribution(
            firstClass: Int(Double(baseDemand.firstClass) * firstMultiplier),
            business: Int(Double(baseDemand.business) * businessMultiplier),
            premiumEconomy: Int(Double(baseDemand.premiumEconomy) * premiumMultiplier),
            economy: Int(Double(baseDemand.economy) * economyMultiplier)
        )
        
        // Fill seats based on adjusted demand (can't exceed available seats)
        let seatsBooked = SeatingConfig(
            economy: min(adjustedDemand.economy, seatingLayout.economy),
            premiumEconomy: min(adjustedDemand.premiumEconomy, seatingLayout.premiumEconomy),
            business: min(adjustedDemand.business, seatingLayout.business),
            first: min(adjustedDemand.firstClass, seatingLayout.first)
        )
        
        // Calculate revenue
        let revenue = Double(
            Double(seatsBooked.economy) * pricing.economy +
            Double(seatsBooked.premiumEconomy) * pricing.premiumEconomy +
            Double(seatsBooked.business) * pricing.business +
            Double(seatsBooked.first) * pricing.first
        )
        
        // Update flight status
        isAirborne = true
        takeoffTime = Date()
        landingTime = takeoffTime!.adding(hours: Double(distance) / Double(planeSelected.cruiseSpeed))
        estimatedLandingTime = takeoffTime!.adding(hours: Double(distance) / Double(planeSelected.cruiseSpeed))
        passengerSeatsUsed = seatsBooked
        userDataProvided.wrappedValue.accountBalance += revenue
        currentAirportLocation = nil
        userDataProvided.wrappedValue.currentlyHoldingFuel -= Int(fuelRequired)
        
        let notificationsManager = NotificationsManager()
        
        notificationsManager.schedule(notificationType: .arrival, planeInvolved: self, date: landingTime!, userData: userDataProvided.wrappedValue)
                
        return DepartureDoneSuccessfullyItems(
            departedSuccessfully: true,
            moneyMade: revenue,
            seatsUsedInPlane: seatsBooked,
            seatingConfigOfJet: seatingLayout
        )
    }
    
    mutating func markJetAsArrived(_ userDataProvided: Binding<UserData>) {
        let diffComponenets = Calendar.current.dateComponents([.hour], from: takeoffTime!, to: landingTime!)
        let hours = diffComponenets.hour
        hoursFlown = hoursFlown + Double(hours!)
        let db = AirportDatabase()
        let distanceFlown = db.calculateDistance(from: assignedRoute!.originAirport, to: assignedRoute!.arrivalAirport)
        let degradationRate = 1.0 / Double.random(in: 35000...65000)
        lastHoursOfPlaneDuringMaintainance = lastHoursOfPlaneDuringMaintainance + Double(hours!)
        condition = max(0.0, 1.0 - Double(kilometersTravelledSinceLastMaintainence) * degradationRate)
        
        isAirborne = false
        takeoffTime = nil
        landingTime = nil
        estimatedLandingTime = nil
        
        let holdingDepartureAirport: Airport = assignedRoute!.arrivalAirport
        currentAirportLocation = assignedRoute!.arrivalAirport
        assignedRoute = Route(originAirport: holdingDepartureAirport, arrivalAirport: assignedRoute!.originAirport)
        
        userDataProvided.wrappedValue.xp = userDataProvided.wrappedValue.xp + 1
    }
    
    /// Repair starter
    /// Set a timer
    mutating func setJetUnderMaintainance(_ userDataProvided: Binding<UserData>) {
        let currentDate = Date()
        let selectedPlane = AircraftDatabase.shared.allAircraft.first(where: { $0.id == aircraftID })!
        condition = 1.0
        endMaintainanceDate = currentDate.adding(hours: 3.0)
        print(userDataProvided.wrappedValue.accountBalance)
        userDataProvided.wrappedValue.accountBalance = userDataProvided.wrappedValue.accountBalance - selectedPlane.maintenanceCostPerHour * lastHoursOfPlaneDuringMaintainance
        print(userDataProvided.wrappedValue.accountBalance)
        lastHoursOfPlaneDuringMaintainance = 0
    }
    
    /// Calculates demand multiplier based on user pricing vs market pricing
    /// - Returns a value between 0.3 and 1.5:
    /// - < 1.0 = prices too high (reduced demand)
    /// - 1.0 = market price (normal demand)
    /// - >  1.0 = competitive pricing (increased demand)
    private func calculatePricingMultiplier(userPrice: Double, marketPrice: Double, elasticity: Double) -> Double {
        guard marketPrice > 0 else { return 1.0 }
        
        let priceRatio = userPrice / marketPrice
        // Formula: demand = priceRatio^(-elasticity)
        // If priceRatio = 0.8 (20% discount) → demand increases
        // If priceRatio = 1.2 (20% premium) → demand dec   reases
        let demandChange = pow(priceRatio, -elasticity)
        
        // Clamp between 0.3 (70% demand loss) and 1.5 (50% demand boost)
        return min(max(demandChange, 0.3), 1.5)
    }
    
}


/// new stuff for settings
/// notifications and airline code
enum AllowedNotificationTypes: Codable {
    case arrival, maintainanceEnd, campaignEnd
}

enum PreferedAirlineCodeType: Codable {
    case iata, icao
}

/// SwiftData class
/// name --> CEO name, airlineName --> name of the airline, airlineIataCode --> Airline IATA code, that will be used at the start of all
/// flights under that airline, planes [FleetItem] --> Contains a list of the planes
@Model
class UserData {
    /// New for settings
    var allowedNotificationTypes: [AllowedNotificationTypes] = [AllowedNotificationTypes.arrival, AllowedNotificationTypes.maintainanceEnd, AllowedNotificationTypes.campaignEnd]
    var preferredAirlineCodeType: String = "iata"
    var name: String
    var airlineName: String
    var airlineIataCode: String
    var planes: [FleetItem]
    // Reset XP to 0 when new level is reached
    var xp: Int = 0
    var levels: Int = 0
    var xpPoints: Int = 0
    var airlineReputation: Double = 0.6
    var reliabilityIndex: Double = 0.7
    var fuelDiscountMultiplier: Double = 1
    var lastFuelPrice: Double = 750
    var fuelPurchasedByUserAtLastFuelPrice: Double = 0
    var currentFuelPrice: Double = 750
    var lastFewFuelPricesForGraph: [Double] = [1100, 2100, 300, 1700, 2600, 900, 1400, 1300, 2700, 750]
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
    // Percentage airline improves during campaign. After campaign, airline improves reputation by 1% of their improvement during the campaign
    // airline also looses reputation when their maintainance or happiness drops below 0.7
    var deliveryHubs: [Airport]
    var accountBalance: Double
    var lastLogin: Date = Date()
    var lastFuelPriceCalculationDate: Date = Date()
    var amountSpentOnFuelInTheLastWeek: Double = 0
    var amountSpentOnPlanesInTheLastWeek: Double = 0
    var amountSpentOnHubsAccquisitionInTheLastWeek: Double = 0
    var amountOfMoneyMadeFromDepartures: Double = 0
    var hubsAcquired: [Airport] = []
    var daysPassedSinceStartOfFinancialWeek: Int = 0
    var campaignEnd: Date? = nil
    var baseReputation: Double = 0.6
    var preferedAirlineCodeType: PreferedAirlineCodeType {
        if preferredAirlineCodeType == "iata" {
            return .iata
        } else {
            return .icao
        }
    }
    var cashToPayAsSalaryPerWeek: Int {
        return weeklyPilotSalary * pilots + weeklyFlightAttendentSalary * flightAttendents + weeklyFlightMaintainanceCrewSalary * maintainanceCrew
    }
    var progressToNextXPLevel: Double {
        return fmod(Double(xp), Double(levels)) / Double(levels)
    }
    var xpRequiredForNextXPLevel: Int {
        return levels - (xp % levels)
    }
    // For fuel calculations
    var fuelUsedInDepartingAllJets: Double {
        let airportDB = AirportDatabase()
        var totalFuelConsumptionOfAllPlanes: Double = 0
        var totalDistanceOfPlanesTravelled: Double = 0
        
        for plane in planes {
            totalFuelConsumptionOfAllPlanes += AircraftDatabase.shared.allAircraft.first(where: { $0.id == plane.aircraftID })!.fuelBurnRate
            if let assignedRoute = plane.assignedRoute {
                totalDistanceOfPlanesTravelled += Double(airportDB.calculateDistance(from: assignedRoute.originAirport, to: assignedRoute.arrivalAirport))
            }
        }
        
        let averageFuelConsumptionOfAllPlanes = totalFuelConsumptionOfAllPlanes / Double(planes.count)
        
        return averageFuelConsumptionOfAllPlanes * totalDistanceOfPlanesTravelled
    }
    
    init(name: String, airlineName: String, airlineIataCode: String, planes: [FleetItem], xp: Int, xpPoints: Int = 0, levels: Int, airlineReputation: Double, reliabilityIndex: Double, fuelDiscountMultiplier: Double, lastFuelPrice: Double, pilots: Int, flightAttendents: Int, maintainanceCrew: Int, currentlyHoldingFuel: Int, maxFuelHoldable: Int, weeklyPilotSalary: Int, weeklyFlightAttendentSalary: Int, weeklyFlightMaintainanceCrewSalary: Int, pilotHappiness: Double, flightAttendentHappiness: Double, maintainanceCrewHappiness: Double, campaignRunning: Bool, campaignEffectiveness: Double? = nil, deliveryHubs: [Airport], accountBalance: Double) {
        self.preferredAirlineCodeType = "iata"
        self.allowedNotificationTypes = [AllowedNotificationTypes.arrival, AllowedNotificationTypes.maintainanceEnd, AllowedNotificationTypes.campaignEnd]
        self.name = name
        self.airlineName = airlineName
        self.airlineIataCode = airlineIataCode
        self.planes = planes
        self.xp = xp
        self.xpPoints = xpPoints
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
        self.lastLogin = Date()
        self.lastFuelPriceCalculationDate = Date()
        self.amountSpentOnFuelInTheLastWeek = 0
        self.amountSpentOnPlanesInTheLastWeek = 0
        self.amountSpentOnHubsAccquisitionInTheLastWeek = 0
        self.amountOfMoneyMadeFromDepartures = 0
        self.hubsAcquired = []
        self.daysPassedSinceStartOfFinancialWeek = 0
        self.fuelPurchasedByUserAtLastFuelPrice = 0
        self.currentFuelPrice = 750
        self.lastFewFuelPricesForGraph = [1100, 2100, 300, 1700, 2600, 900, 1400, 1300, 2700, 750]
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

func timeTakenForCampaignEnd(_ currentDate: Date, userData: UserData) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .short
    formatter.zeroFormattingBehavior = .dropAll
    return formatter.string(from: currentDate, to: userData.campaignEnd!)!
}

func resetCampaignUponEnd(userData: Binding<UserData>) {
    userData.wrappedValue.campaignRunning = false
    userData.wrappedValue.airlineReputation = userData.wrappedValue.baseReputation
    userData.wrappedValue.campaignEnd = nil
    userData.wrappedValue.campaignEffectiveness = nil
}

/// Exists for the sole purpose of maps
/// Selects the type of the airport that needs to be changed
enum AirportType: Codable {
    case departure, arrival, stopover
}
