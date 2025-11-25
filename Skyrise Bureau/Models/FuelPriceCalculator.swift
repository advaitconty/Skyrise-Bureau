//
//  FuelPriceCalculator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 23/11/25.
//

import Foundation
import SwiftUI

/// Fuel price logic
/// The process
/// 1. Check final fuel price
/// 2. Calculate delta in fuel price over last 20 results (refresh every 3 hours)
/// 3. Randomly select a fuel price multipler (from 0.3x of current price to 3x of current price - chances will change based on delta of all fuel prices)


/// Notes:
/// Max allowed fuel price: $2700
/// Lowest allowed fuel price: $300
/// Fuel price should be in increments of $100
/// Price is based on how much it would cost to purchase 1000kg of fuel

func calculateNextFuelPrice(_ currentFuelPrice: Double, userData: Binding<UserData>) {
    userData.wrappedValue.lastFuelPrice = userData.wrappedValue.currentFuelPrice
    let reasonableMaxFuelToGetInOneRun: Double = userData.wrappedValue.fuelUsedInDepartingAllJets
    var multiplierTop: Double = currentFuelPrice / 2700
    var multiplierBottom: Double = currentFuelPrice / 300
    if userData.wrappedValue.fuelPurchasedByUserAtLastFuelPrice > reasonableMaxFuelToGetInOneRun {
        multiplierBottom += Double.random(in: Double(multiplierBottom)...Double(multiplierBottom + 0.01))
    } else {
        multiplierTop += Double.random(in: Double(multiplierTop - 0.01)...Double(multiplierTop))
    }
    
    if userData.wrappedValue.lastFuelPrice < 750 {
        multiplierBottom += Double.random(in: Double(multiplierBottom)...Double(multiplierBottom + 0.01))
    } else {
        multiplierTop += Double.random(in: Double(multiplierTop - 0.01)...Double(multiplierTop))
    }
    
    let unformattedCurrentFuelPrice: Double = Double.random(in: multiplierBottom...multiplierTop)
    
    userData.wrappedValue.currentFuelPrice = round(unformattedCurrentFuelPrice / 100) * 100
}
