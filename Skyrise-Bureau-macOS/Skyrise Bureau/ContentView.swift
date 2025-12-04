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

struct ContentView: View {
    var moidifiableUserdata: Binding<UserData> {
        Binding {
            userData.first ?? testUserData
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
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    @State var showFinancialsAvailableAlert: Bool = false
    let planeArrivalTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let fuelPriceTimer = Timer.publish(every: 7200, on: .main, in: .common).autoconnect() // 2 hours
    var resetUserData: Bool
    var useTestData: DataTypeToUse
    var body: some View {
        VStack {
            MapView(userData: moidifiableUserdata)
                .onAppear {
                    /// Test stubs
                    if resetUserData {
                        for item in userData {
                            modelContext.delete(item)
                        }
                        try? modelContext.save()
                    } else if useTestData != .none {
                        var value: UserData
                        if useTestData == .flyingPlanes {
                            value = testUserDataWithFlyingPlanes
                            print("Flying planes test data used")
                        } else if useTestData == .regular {
                            value = testUserData
                            print("Regular test data used")
                        } else {
                            value = testUserDataEndgame
                            print("Endgame test user data being used")
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
                    
                    let todaysDate: Date = Date()
                    let calendar = Calendar.current
                    guard let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: moidifiableUserdata.wrappedValue.lastLogin), to: calendar.startOfDay(for: todaysDate) ).day else { return }
                    moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek = days + moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek
                    if moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek >= 7 {
                        let numberOfDeductionsToMakeForSalary: Int
                        numberOfDeductionsToMakeForSalary = Int(moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek / 7)
                        moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek = moidifiableUserdata.wrappedValue.daysPassedSinceStartOfFinancialWeek % 7
                        moidifiableUserdata.wrappedValue.accountBalance = moidifiableUserdata.wrappedValue.accountBalance - Double(moidifiableUserdata.wrappedValue.cashToPayAsSalaryPerWeek * numberOfDeductionsToMakeForSalary)
                    }
                    moidifiableUserdata.wrappedValue.lastLogin = todaysDate
                    if days != 0 {
                        print(days)
                        for _ in 1...days {
                            moidifiableUserdata.wrappedValue.flightAttendentHappiness -= Double.random(in: 0.01...0.03)
                            moidifiableUserdata.wrappedValue.pilotHappiness -= Double.random(in: 0.01...0.03)
                            moidifiableUserdata.wrappedValue.maintainanceCrewHappiness -= Double.random(in: 0.01...0.03)
                            
                        }
                    }
                    
                    // Recalculate fuel price for the time passed since last open
                    let hoursSinceLastFuelUpdate = Calendar.current.dateComponents([.hour], from: moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate, to: todaysDate).hour ?? 0
                    if hoursSinceLastFuelUpdate >= 2 {
                        let numberOfUpdates = hoursSinceLastFuelUpdate / 2
                        for _ in 0..<numberOfUpdates {
                            calculateNextFuelPrice(userData: moidifiableUserdata)
                        }
                    }
                    moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate = todaysDate
                    
                }
            /// Manages marking the plane as arrived or not at the first possible instant
                .onReceive(planeArrivalTimer) { _ in
                    let currentDate = Date()
                    for (index, plane) in moidifiableUserdata.wrappedValue.planes.enumerated() {
                        if plane.isAirborne && plane.estimatedLandingTime != nil {
                            if currentDate >= plane.estimatedLandingTime! {
                                moidifiableUserdata.wrappedValue.planes[index].markJetAsArrived(moidifiableUserdata)
                            }
                        } else if plane.inMaintainance {
                            if currentDate >= plane.endMaintainanceDate! {
                                moidifiableUserdata.wrappedValue.planes[index].markJetAsMaintainanceDone()
                            }
                        }
                    }
                    if moidifiableUserdata.wrappedValue.campaignRunning {
                        if moidifiableUserdata.wrappedValue.campaignEnd! <= currentDate {
                            resetCampaignUponEnd(userData: moidifiableUserdata)
                        }
                    }
                    
                    if moidifiableUserdata.wrappedValue.xpRequiredForNextXPLevel == 0 {
                        moidifiableUserdata.wrappedValue.levels += 1
                        moidifiableUserdata.wrappedValue.xpPoints += 1
                    }
                }
                .onReceive(fuelPriceTimer) { _ in
                    calculateNextFuelPrice(userData: moidifiableUserdata)
                    moidifiableUserdata.wrappedValue.lastFuelPriceCalculationDate = Date()
                }
                .onAppear {
                    let notificationsManager = NotificationsManager()
                    notificationsManager.requestPermission()
                    
                    /// COMMENT FOR FINAL REALEASE
                    /// debug stub to remove all notifications
//                    notificationsManager.removeAll()
                }
        }

    }
}

#Preview {
    ContentView(resetUserData: false, useTestData: .endGame)
}
