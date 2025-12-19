//
//  VolatilityCalculator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI
import Foundation

extension FuelPriceView {
    func volatilityCalculator(_ items: [Double]) -> String {
        var returns: [Double] = []
        for i in 1..<items.count {
            let percentChange = (items[i] - items[i-1]) / items[i-1]
            returns.append(percentChange)
        }
        
        let mean = returns.reduce(0, +) / Double(returns.count)
        
        let squardDifference = returns.map { pow($0 - mean, 2) }
        let variance = squardDifference.reduce(0, +) / Double(returns.count)
        
        let volatility = sqrt(variance)
        
        let stringItem = String(format: "%.2f", volatility * 100)
        
        return stringItem
    }
}
