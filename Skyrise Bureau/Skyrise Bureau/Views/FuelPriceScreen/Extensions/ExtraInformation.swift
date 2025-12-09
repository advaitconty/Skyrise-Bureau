//
//  ExtraInformation.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI

extension FuelPriceView {
    func extraInformation(_ width: CGFloat) -> some View {
        // Extra information
        VStack {
            HStack {
                Text("TRANSACTION\nPRICE: ")
                    .fontWidth(.condensed)
                Spacer()
                Text("$\(Int(userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase))")
                    .font(.title2)
                    .fontWidth(.expanded)
                    .contentTransition(.numericText(countsDown: true))
            }
            
            HStack {
                Text("REMAINING\nBALANCE:")
                    .fontWidth(.condensed)
                Spacer()
                Text("$\((userData.wrappedValue.accountBalance - userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase).withCommas)")
                    .font(.title2)
                    .fontWidth(.expanded)
                    .contentTransition(.numericText(countsDown: true))
            }
        }
        .frame(width: width / 2 - 55)
        .padding(14)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}
