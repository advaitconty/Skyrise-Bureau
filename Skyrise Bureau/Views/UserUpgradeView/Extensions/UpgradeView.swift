//
//  UpgradeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 3/12/25.
//

import SwiftUI

extension UserUpgradeView {
    func upgradeView() -> some View {
        VStack {
            HStack {
                Text("UPGRADES")
                    .font(.title3)
                    .fontWidth(.expanded)
                Spacer()
            }
            // MARK: Holding fuel tank capacity
            HStack {
                (Text("HOLDING FUEL TANK UPGRADE\n")
                    .fontWidth(.expanded)
                +
                Text("Increase your maximum fuel capacity. Your current maximum is \(userData.wrappedValue.maxFuelHoldable.withCommas)kg. Upgrading lets you buy and store more fuel when prices are cheap.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        userData.wrappedValue.accountBalance -= Double((userData.wrappedValue.maxFuelHoldable - 4000000) * 10)
                        userData.wrappedValue.xpPoints -= (userData.wrappedValue.maxFuelHoldable - 4000000) / 1000000
                        userData.wrappedValue.maxFuelHoldable += 1000000
                    }
                } label: {
                    VStack {
                        Text("+1,000,000kg")
                            .fontWidth(.condensed)
                        Text("$\(((userData.wrappedValue.maxFuelHoldable - 4000000) * 10).withCommas) and \(((userData.wrappedValue.maxFuelHoldable - 4000000)/1000000)) XP Point\(((userData.wrappedValue.maxFuelHoldable - 4000000)/1000000).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding(0)
                }
                .disabled(
                    Double((userData.wrappedValue.maxFuelHoldable - 4_000_000) * 10)
                        > userData.wrappedValue.accountBalance
                    ||
                    ((userData.wrappedValue.maxFuelHoldable - 4_000_000) / 1_000_000)
                        > userData.wrappedValue.xpPoints
                )
            }
            
            // MARK: Repuation boost
            HStack {
                (Text("PERMENANT REPUTATION BOOST\n")
                    .fontWidth(.expanded)
                +
                 Text("Permenantly increase your base reputation, allowing you to attract more passengers on your flight without having to consistently keep an active marketing campaign. Current base reputation: \((userData.wrappedValue.baseReputation * 100).withCommas)%.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        userData.wrappedValue.accountBalance -= Double(((userData.wrappedValue.baseReputation - 0.55) / 5 * 5000000000))
                        userData.wrappedValue.xpPoints -= Int((userData.wrappedValue.baseReputation - 0.55) / 5 * 500)
                        userData.wrappedValue.baseReputation += 0.05
                        if !userData.wrappedValue.campaignRunning {
                            userData.wrappedValue.airlineReputation = userData.wrappedValue.baseReputation
                        }
                    }
                } label: {
                    VStack {
                        Text("+5%")
                            .fontWidth(.condensed)
                        Text("$\(((userData.wrappedValue.baseReputation - 0.55) / 5 * 5000000000).withCommas) and \(((userData.wrappedValue.baseReputation - 0.55) / 5 * 500).withCommas) XP Point\(((Int(userData.wrappedValue.baseReputation - 0.55) / 5 * 500)).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding(0)
                }
                .disabled(
                    (userData.wrappedValue.maxFuelHoldable - 4000000) * 10 > Int(userData.wrappedValue.accountBalance) ||
                    userData.wrappedValue.xpPoints < (userData.wrappedValue.maxFuelHoldable - 4000000)/1000000
                )
            }

        }
    }
}
