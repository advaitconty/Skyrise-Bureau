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

func calculateNextFuelPrice(userData: Binding<UserData>) {
    print("Recalculating fuel price...")
    
    let minPrice = 300.0
    let maxPrice = 2700.0
    let currentPrice = userData.wrappedValue.currentFuelPrice
    
    /// Save the current price as the last price
    userData.wrappedValue.lastFuelPrice = currentPrice
    
        /// 1. Determine a base random change (e.g., up to 25% variation)
    var changePercentage = Double.random(in: -0.25...0.25)
    
    /// 2. Apply market pressure to correct extreme prices
    /// If price is low, it's more likely to go up.
    if currentPrice < 800 {
        changePercentage += Double.random(in: 0.0...0.15) // Add upward pressure
    }
    /// If price is high, it's more likely to go down.
    if currentPrice > 2000 {
        changePercentage -= Double.random(in: 0.0...0.15) // Add downward pressure
    }
    
    /// 3. Adjust based on user's last purchase behavior
    let reasonableMaxFuelToGetInOneRun = userData.wrappedValue.fuelUsedInDepartingAllJets
    if userData.wrappedValue.fuelPurchasedByUserAtLastFuelPrice > reasonableMaxFuelToGetInOneRun {
        /// User bought a lot, so increase the price (demand is high)
        changePercentage += Double.random(in: 0.05...0.10)
    } else {
        /// User bought little or no fuel, so decrease the price (demand is low)
        changePercentage -= Double.random(in: 0.05...0.10)
    }
    
    /// 4. Calculate the new price
    var newPrice = currentPrice * (1 + changePercentage)
    
    /// 5. Clamp the price within the allowed min/max bounds
    newPrice = max(minPrice, min(maxPrice, newPrice))
    
    /// 6. Round to the nearest 100
    let finalPrice = (newPrice / 100).rounded() * 100
    
    /// Ensure the price doesn't get stuck if it rounds to the same value
    if finalPrice == currentPrice {
        /// If it's the same, nudge it by +/- 100, respecting bounds
        let nudge = Double.random(in: 0...1) > 0.5 ? 100.0 : -100.0
        let nudgedPrice = finalPrice + nudge
        userData.wrappedValue.currentFuelPrice = max(minPrice, min(maxPrice, nudgedPrice))
    } else {
        userData.wrappedValue.currentFuelPrice = finalPrice
    }
    
    /// Reset the purchase tracker for the new price period
    userData.wrappedValue.fuelPurchasedByUserAtLastFuelPrice = 0
}
