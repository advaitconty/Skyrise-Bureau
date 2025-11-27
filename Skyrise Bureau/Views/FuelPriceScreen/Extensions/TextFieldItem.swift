//
//  TextFieldItem.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI

extension FuelPriceView {
    func textFieldItem() -> some View {
        HStack {
            Text("Amount to order:")
                .fontWidth(.condensed)
            TextField("1000", value: $amountOfFuelUserWantsToPurchase, format: .number)
                .fontWidth(.condensed)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .onChange(of: amountOfFuelUserWantsToPurchase) {
                    if userData.wrappedValue.maxFuelHoldable < userData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) && userData.wrappedValue.accountBalance - userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase < 0 {
                        withAnimation {
                            exceedMax = true
                            notEnoughBalance = true
                        }
                    } else {
                        if userData.wrappedValue.maxFuelHoldable < userData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase) {
                            withAnimation {
                                exceedMax = true
                            }
                        } else if userData.wrappedValue.accountBalance - userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase < 0 {
                            withAnimation {
                                notEnoughBalance = true
                            }
                        } else {
                            withAnimation {
                                exceedMax = false
                                notEnoughBalance = false
                            }
                        }
                    }
                }
            Text("kg")
                .fontWidth(.condensed)
        }
    }
}
