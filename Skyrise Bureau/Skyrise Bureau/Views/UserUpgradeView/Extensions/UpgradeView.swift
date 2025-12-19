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
                Text("Increase your maximum fuel capacity. Your current maximum is \(userData.maxFuelHoldable.withCommas)kg. Upgrading lets you buy and store more fuel when prices are cheap.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        userData.accountBalance -= Double((userData.maxFuelHoldable - 4000000) * 10)
                        userData.xpPoints -= (userData.maxFuelHoldable - 4000000) / 1000000
                        userData.maxFuelHoldable += 1000000
                    }
                } label: {
                    VStack {
                        Text("+1,000,000kg")
                            .fontWidth(.condensed)
                        Text("$\(((userData.maxFuelHoldable - 4000000) * 10).withCommas) and \(((userData.maxFuelHoldable - 4000000)/1000000)) XP Point\(((userData.maxFuelHoldable - 4000000)/1000000).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding()
                }
                .disabled(
                    Double((userData.maxFuelHoldable - 4_000_000) * 10)
                        > userData.accountBalance
                    ||
                    ((userData.maxFuelHoldable - 4_000_000) / 1_000_000)
                        > userData.xpPoints
                )
                .adaptiveButtonStyle()
            }
            
            // MARK: Repuation boost
            HStack {
                (Text("PERMENANT REPUTATION BOOST\n")
                    .fontWidth(.expanded)
                +
                 Text("Permenantly increase your base reputation, allowing you to attract more passengers on your flight without having to consistently keep an active marketing campaign. Current base reputation: \((userData.baseReputation * 100).withCommas)%.")
                    .fontWidth(.condensed))
                .contentTransition(.numericText(countsDown: true))
                Spacer()
                
                Button {
                    withAnimation {
                        userData.accountBalance -= Double(((userData.baseReputation - 0.55) / 5 * 5000000000))
                        userData.xpPoints -= Int((userData.baseReputation - 0.55) / 5 * 500)
                        userData.baseReputation += 0.05
                        if !userData.campaignRunning {
                            userData.airlineReputation = userData.baseReputation
                        }
                    }
                } label: {
                    VStack {
                        Text("+5%")
                            .fontWidth(.condensed)
                        Text("$\(((userData.baseReputation - 0.55) / 5 * 5000000000).withCommas) and \(((userData.baseReputation - 0.55) / 5 * 500).withCommas) XP Point\(((Int(userData.baseReputation - 0.55) / 5 * 500)).plu())")
                            .fontWidth(.compressed)
                    }
                    .padding()
                }
                .disabled(
                    (userData.maxFuelHoldable - 4000000) * 10 > Int(userData.accountBalance) ||
                    userData.xpPoints < (userData.maxFuelHoldable - 4000000)/1000000
                )
                .adaptiveButtonStyle()
            }
            
            Spacer()
        }
    }
}
