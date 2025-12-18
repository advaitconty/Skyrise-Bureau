//
//  ContentView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData
import Foundation
import Combine

/// Default user data
/// to be used for initialisation
let newUserData = UserData(name: "", airlineName: "", airlineIataCode: "", planes: [], xp: 0, levels: 1, airlineReputation: 0.6, reliabilityIndex: 0.7, fuelDiscountMultiplier: 1, lastFuelPrice: 0.75, pilots: 3, flightAttendents: 3, maintainanceCrew: 3, currentlyHoldingFuel: 1_000_000, maxFuelHoldable: 4_000_000, weeklyPilotSalary: 400, weeklyFlightAttendentSalary: 300, weeklyFlightMaintainanceCrewSalary: 250, pilotHappiness: 0.95, flightAttendentHappiness: 0.95, maintainanceCrewHappiness: 0.95, campaignRunning: false, deliveryHubs: [], accountBalance: 0)

struct ContentView: View {
    @State var showWelcome: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    @State var showSetupScreen: Bool = false
    var modifiableUserData: Binding<UserData> {
        Binding {
            if let userData = userData.first {
                if userData.planes.isEmpty {
                    showSetupScreen = true
                }
                return userData
            } else {
                modelContext.insert(newUserData)
                showSetupScreen = true
                return newUserData
            }
        } set: { value in
            if let item = userData.first {
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
                print("saving userdata...")
                try? modelContext.save()
                print("saved userdata successfully")
            }
        }
    }
    let planeArrivalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let fuelPriceTimer = Timer.publish(every: 7200, on: .main, in: .common).autoconnect()
    let resetUserData: Bool
    let useTestData: DataTypeToUse
    
    var body: some View {
        VStack {
            MapManagerView(userData: modifiableUserData)
                .onAppear {
                    if !showSetupScreen {
                        /// DEBUG CONTENT:
                        /// DO NOT REMOVE. Ensure all passed through variables are updated accordingly
                        if resetUserData {
                            for userDataItem in userData {
                                modelContext.delete(userDataItem)
                            }
                            try? modelContext.save()
                        }
                        if useTestData != .none {
                            var value: UserData
                            if useTestData == .regular {
                                value = testUserData
                            } else if useTestData == .flyingPlanes {
                                value = testUserDataWithFlyingPlanes
                            } else {
                                value = testUserDataEndgame
                            }
                            
                            if let item = userData.first {
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
                        
                        /// NOrmal content
                        /// This stuff stays
                        
                        // Salary Deduction
                        let todaysDate: Date = Date()
                        let calendar = Calendar.current
                        guard let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: modifiableUserData.wrappedValue.lastLogin), to: calendar.startOfDay(for: todaysDate) ).day else { return }
                        modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek = days + modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek
                        if modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek >= 7 {
                            let numberOfDeductionsToMakeForSalary: Int
                            numberOfDeductionsToMakeForSalary = Int(modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek / 7)
                            modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek = modifiableUserData.wrappedValue.daysPassedSinceStartOfFinancialWeek % 7
                            modifiableUserData.wrappedValue.accountBalance = modifiableUserData.wrappedValue.accountBalance - Double(modifiableUserData.wrappedValue.cashToPayAsSalaryPerWeek * numberOfDeductionsToMakeForSalary)
                        }
                        
                        // Login date update thingy
                        modifiableUserData.wrappedValue.lastLogin = todaysDate
                        
                        // Happiness reduction
                        if days != 0 {
                            for _ in 1...days {
                                modifiableUserData.wrappedValue.flightAttendentHappiness -= Double.random(in: 0.01...0.03)
                                modifiableUserData.wrappedValue.pilotHappiness -= Double.random(in: 0.01...0.03)
                                modifiableUserData.wrappedValue.maintainanceCrewHappiness -= Double.random(in: 0.01...0.03)
                                
                            }
                        }
                        
                        // Recalculate fuel price for the time passed since last open
                        let hoursSinceLastFuelUpdate = Calendar.current.dateComponents([.hour], from: modifiableUserData.wrappedValue.lastFuelPriceCalculationDate, to: todaysDate).hour ?? 0
                        if hoursSinceLastFuelUpdate >= 2 {
                            let numberOfUpdates = hoursSinceLastFuelUpdate / 2
                            for _ in 0..<numberOfUpdates {
                                calculateNextFuelPrice(userData: modifiableUserData)
                            }
                        }
                        modifiableUserData.wrappedValue.lastFuelPriceCalculationDate = todaysDate
                    }
                }
            /// Manages marking the plane as arrived or not at the first possible instant
                .onReceive(planeArrivalTimer) { _ in
                    let currentDate = Date()
                    for (index, plane) in modifiableUserData.wrappedValue.planes.enumerated() {
                        if plane.isAirborne && plane.estimatedLandingTime != nil {
                            if currentDate >= plane.estimatedLandingTime! {
                                modifiableUserData.wrappedValue.planes[index].markJetAsArrived(modifiableUserData)
                            }
                        } else if plane.inMaintainance {
                            if currentDate >= plane.endMaintainanceDate! {
                                modifiableUserData.wrappedValue.planes[index].markJetAsMaintainanceDone()
                            }
                        }
                    }
                    if modifiableUserData.wrappedValue.campaignRunning {
                        if modifiableUserData.wrappedValue.campaignEnd! <= currentDate {
                            resetCampaignUponEnd(userData: modifiableUserData)
                        }
                    }
                    
                    if modifiableUserData.wrappedValue.xpRequiredForNextXPLevel == 0 {
                        modifiableUserData.wrappedValue.levels += 1
                        modifiableUserData.wrappedValue.xpPoints += 1
                    }
                }
                .onReceive(fuelPriceTimer) { _ in
                    calculateNextFuelPrice(userData: modifiableUserData)
                    modifiableUserData.wrappedValue.lastFuelPriceCalculationDate = Date()
                }
                .onAppear {
                    let notificationsManager = NotificationsManager()
                    notificationsManager.requestPermission()
                }
                .fullScreenCover(isPresented: $showSetupScreen) {
                    SetupView(userData: modifiableUserData)
                        .interactiveDismissDisabled(true)
                }
        }
        .statusBarHidden()
    }
}

#Preview {
    ContentView(resetUserData: false, useTestData: .endGame)
}
