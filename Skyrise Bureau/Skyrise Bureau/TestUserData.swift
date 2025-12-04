//
//  TestUserData.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import Foundation

var testUserData = UserData(name: "Advait",
                            airlineName: "IndiGo Atlantic",
                            airlineIataCode: "6E",
                            planes: [
                                FleetItem(aircraftID: "IL96-400M",
                                          aircraftname: "Suka Blyat",
                                          registration: "VT-SBL",
                                          hoursFlown: 3,
                                          assignedRoute: Route(originAirport: Airport(
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
                            xp: 250,
                            xpPoints: 8,
                            levels: 8,
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
                originAirport: Airport(
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
                originAirport: Airport(
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
                originAirport: Airport(
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
                originAirport: Airport(
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
    xp: 2800,
    xpPoints: 95,
    levels: 95,
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

/// Test user data for an endgame player
/// This user has completed ~15,000 departures (15,000 XP) and is at level 50
let testUserDataEndgame = UserData(
    name: "Marcus Sterling",
    airlineName: "Global Skies International",
    airlineIataCode: "GSI",
    planes: [
        FleetItem(aircraftID: "B777-300ER", aircraftname: "Crown Jewel", registration: "N-GSI001", hoursFlown: 24500, condition: 0.87, seatingLayout: SeatingConfig(economy: 264, premiumEconomy: 48, business: 35, first: 8), kilometersTravelledSinceLastMaintainence: 12400, currentAirportLocation: Airport(name: "John F. Kennedy International Airport", city: "New York", country: "United States", iata: "JFK", icao: "KJFK", region: .northAmerica, latitude: 40.6413, longitude: -73.7781, runwayLength: 4423, elevation: 4, demand: AirportDemand(passengerDemand: 9.5, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.80), facilities: AirportFacilities(terminalCapacity: 200000, cargoCapacity: 3500, gatesAvailable: 128, slotEfficiency: 0.91))),
        FleetItem(aircraftID: "A350-900", aircraftname: "Prestige", registration: "N-GSI002", hoursFlown: 22100, condition: 0.91, seatingLayout: SeatingConfig(economy: 280, premiumEconomy: 40, business: 30, first: 6), kilometersTravelledSinceLastMaintainence: 10800, currentAirportLocation: Airport(name: "Singapore Changi Airport", city: "Singapore", country: "Singapore", iata: "SIN", icao: "WSSS", region: .asia, latitude: 1.3644, longitude: 103.9915, runwayLength: 4000, elevation: 7, demand: AirportDemand(passengerDemand: 9.8, cargoDemand: 9.2, businessTravelRatio: 0.72, tourismBoost: 0.90), facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4200, gatesAvailable: 135, slotEfficiency: 0.95))),
        FleetItem(aircraftID: "B787-9", aircraftname: "Dreamliner Elite", registration: "N-GSI003", hoursFlown: 19800, condition: 0.89, seatingLayout: SeatingConfig(economy: 246, premiumEconomy: 36, business: 28, first: 0), kilometersTravelledSinceLastMaintainence: 9600, currentAirportLocation: Airport(name: "Los Angeles International Airport", city: "Los Angeles", country: "United States", iata: "LAX", icao: "KLAX", region: .northAmerica, latitude: 33.9416, longitude: -118.4085, runwayLength: 3685, elevation: 38, demand: AirportDemand(passengerDemand: 9.4, cargoDemand: 8.3, businessTravelRatio: 0.68, tourismBoost: 0.92), facilities: AirportFacilities(terminalCapacity: 220000, cargoCapacity: 3400, gatesAvailable: 135, slotEfficiency: 0.90))),
        FleetItem(aircraftID: "A320neo", aircraftname: "Efficiency", registration: "N-GSI004", hoursFlown: 18200, condition: 0.93, seatingLayout: SeatingConfig(economy: 180, premiumEconomy: 24, business: 12, first: 0), kilometersTravelledSinceLastMaintainence: 8900, currentAirportLocation: Airport(name: "Dubai International Airport", city: "Dubai", country: "United Arab Emirates", iata: "DXB", icao: "OMDB", region: .asia, latitude: 25.2532, longitude: 55.3657, runwayLength: 4000, elevation: 19, demand: AirportDemand(passengerDemand: 9.7, cargoDemand: 9.0, businessTravelRatio: 0.82, tourismBoost: 0.88), facilities: AirportFacilities(terminalCapacity: 260000, cargoCapacity: 4500, gatesAvailable: 150, slotEfficiency: 0.92))),
        FleetItem(aircraftID: "B777-300ER", aircraftname: "Endurance", registration: "N-GSI005", hoursFlown: 21500, condition: 0.85, seatingLayout: SeatingConfig(economy: 270, premiumEconomy: 40, business: 24, first: 8), kilometersTravelledSinceLastMaintainence: 11200, currentAirportLocation: Airport(name: "London Heathrow Airport", city: "London", country: "United Kingdom", iata: "LHR", icao: "EGLL", region: .europe, latitude: 51.4700, longitude: -0.4543, runwayLength: 3902, elevation: 25, demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 8.8, businessTravelRatio: 0.80, tourismBoost: 0.85), facilities: AirportFacilities(terminalCapacity: 225000, cargoCapacity: 3800, gatesAvailable: 115, slotEfficiency: 0.93))),
        FleetItem(aircraftID: "A380-800", aircraftname: "Mega Carrier", registration: "N-GSI006", hoursFlown: 16800, condition: 0.88, seatingLayout: SeatingConfig(economy: 399, premiumEconomy: 80, business: 76, first: 14), kilometersTravelledSinceLastMaintainence: 8200, currentAirportLocation: Airport(name: "Tokyo Haneda Airport", city: "Tokyo", country: "Japan", iata: "HND", icao: "RJTT", region: .asia, latitude: 35.5494, longitude: 139.7798, runwayLength: 3360, elevation: 11, demand: AirportDemand(passengerDemand: 9.6, cargoDemand: 8.7, businessTravelRatio: 0.78, tourismBoost: 0.82), facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 3600, gatesAvailable: 110, slotEfficiency: 0.94))),
        FleetItem(aircraftID: "B767-300ER", aircraftname: "Workhorse 1", registration: "N-GSI007", hoursFlown: 25200, condition: 0.82, seatingLayout: SeatingConfig(economy: 218, premiumEconomy: 30, business: 16, first: 0), kilometersTravelledSinceLastMaintainence: 12800, currentAirportLocation: Airport(name: "Frankfurt Airport", city: "Frankfurt", country: "Germany", iata: "FRA", icao: "EDDF", region: .europe, latitude: 50.0264, longitude: 8.5722, runwayLength: 4000, elevation: 109, demand: AirportDemand(passengerDemand: 9.2, cargoDemand: 9.5, businessTravelRatio: 0.72, tourismBoost: 0.75), facilities: AirportFacilities(terminalCapacity: 210000, cargoCapacity: 4100, gatesAvailable: 120, slotEfficiency: 0.91))),
        FleetItem(aircraftID: "A330-300", aircraftname: "Wide Body Wonder", registration: "N-GSI008", hoursFlown: 20300, condition: 0.90, seatingLayout: SeatingConfig(economy: 292, premiumEconomy: 42, business: 30, first: 8), kilometersTravelledSinceLastMaintainence: 9900, currentAirportLocation: Airport(name: "Sydney Kingsford Smith Airport", city: "Sydney", country: "Australia", iata: "SYD", icao: "YSSY", region: .australiaAndOceania, latitude: -33.9399, longitude: 151.1753, runwayLength: 3962, elevation: 6, demand: AirportDemand(passengerDemand: 9.0, cargoDemand: 7.8, businessTravelRatio: 0.65, tourismBoost: 0.95), facilities: AirportFacilities(terminalCapacity: 180000, cargoCapacity: 2900, gatesAvailable: 95, slotEfficiency: 0.88))),
        FleetItem(aircraftID: "B737MAX8", aircraftname: "Modern Fleet 1", registration: "N-GSI009", hoursFlown: 8600, condition: 0.96, seatingLayout: SeatingConfig(economy: 160, premiumEconomy: 20, business: 8, first: 0), kilometersTravelledSinceLastMaintainence: 4200, currentAirportLocation: Airport(name: "Paris Charles de Gaulle Airport", city: "Paris", country: "France", iata: "CDG", icao: "LFPG", region: .europe, latitude: 49.0097, longitude: 2.5479, runwayLength: 4000, elevation: 119, demand: AirportDemand(passengerDemand: 9.3, cargoDemand: 8.9, businessTravelRatio: 0.76, tourismBoost: 0.88), facilities: AirportFacilities(terminalCapacity: 215000, cargoCapacity: 3900, gatesAvailable: 110, slotEfficiency: 0.92))),
        FleetItem(aircraftID: "A321neo", aircraftname: "Modern Fleet 2", registration: "N-GSI010", hoursFlown: 7900, condition: 0.97, seatingLayout: SeatingConfig(economy: 194, premiumEconomy: 28, business: 14, first: 0), kilometersTravelledSinceLastMaintainence: 3800, currentAirportLocation: Airport(name: "Amsterdam Airport Schiphol", city: "Amsterdam", country: "Netherlands", iata: "AMS", icao: "EHAM", region: .europe, latitude: 52.3081, longitude: 4.7639, runwayLength: 3500, elevation: -2, demand: AirportDemand(passengerDemand: 8.9, cargoDemand: 9.1, businessTravelRatio: 0.70, tourismBoost: 0.82), facilities: AirportFacilities(terminalCapacity: 190000, cargoCapacity: 3700, gatesAvailable: 105, slotEfficiency: 0.90)))
    ],
    xp: 8750,
    xpPoints: 176,
    levels: 176,
    airlineReputation: 0.98,
    reliabilityIndex: 0.96,
    fuelDiscountMultiplier: 0.42,
    lastFuelPrice: 0.42,
    pilots: 85,
    flightAttendents: 320,
    maintainanceCrew: 80,
    currentlyHoldingFuel: 50_000_000,
    maxFuelHoldable: 65_000_000,
    weeklyPilotSalary: 1200,
    weeklyFlightAttendentSalary: 800,
    weeklyFlightMaintainanceCrewSalary: 950,
    pilotHappiness: 0.98,
    flightAttendentHappiness: 0.97,
    maintainanceCrewHappiness: 0.99,
    campaignRunning: false,
    deliveryHubs: [
        Airport(name: "John F. Kennedy International Airport", city: "New York", country: "United States", iata: "JFK", icao: "KJFK", region: .northAmerica, latitude: 40.6413, longitude: -73.7781, runwayLength: 4423, elevation: 4, demand: AirportDemand(passengerDemand: 9.5, cargoDemand: 8.5, businessTravelRatio: 0.75, tourismBoost: 0.80), facilities: AirportFacilities(terminalCapacity: 200000, cargoCapacity: 3500, gatesAvailable: 128, slotEfficiency: 0.91)),
        Airport(name: "London Heathrow Airport", city: "London", country: "United Kingdom", iata: "LHR", icao: "EGLL", region: .europe, latitude: 51.4700, longitude: -0.4543, runwayLength: 3902, elevation: 25, demand: AirportDemand(passengerDemand: 10.0, cargoDemand: 8.8, businessTravelRatio: 0.80, tourismBoost: 0.85), facilities: AirportFacilities(terminalCapacity: 225000, cargoCapacity: 3800, gatesAvailable: 115, slotEfficiency: 0.93)),
        Airport(name: "Singapore Changi Airport", city: "Singapore", country: "Singapore", iata: "SIN", icao: "WSSS", region: .asia, latitude: 1.3644, longitude: 103.9915, runwayLength: 4000, elevation: 7, demand: AirportDemand(passengerDemand: 9.8, cargoDemand: 9.2, businessTravelRatio: 0.72, tourismBoost: 0.90), facilities: AirportFacilities(terminalCapacity: 240000, cargoCapacity: 4200, gatesAvailable: 135, slotEfficiency: 0.95)),
        Airport(name: "Dubai International Airport", city: "Dubai", country: "United Arab Emirates", iata: "DXB", icao: "OMDB", region: .asia, latitude: 25.2532, longitude: 55.3657, runwayLength: 4000, elevation: 19, demand: AirportDemand(passengerDemand: 9.7, cargoDemand: 9.0, businessTravelRatio: 0.82, tourismBoost: 0.88), facilities: AirportFacilities(terminalCapacity: 260000, cargoCapacity: 4500, gatesAvailable: 150, slotEfficiency: 0.92)),
        Airport(name: "Tokyo Haneda Airport", city: "Tokyo", country: "Japan", iata: "HND", icao: "RJTT", region: .asia, latitude: 35.5494, longitude: 139.7798, runwayLength: 3360, elevation: 11, demand: AirportDemand(passengerDemand: 9.6, cargoDemand: 8.7, businessTravelRatio: 0.78, tourismBoost: 0.82), facilities: AirportFacilities(terminalCapacity: 230000, cargoCapacity: 3600, gatesAvailable: 110, slotEfficiency: 0.94))
    ],
    accountBalance: 1_250_000_000
)
