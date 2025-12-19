//
//  ReputationView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 1/12/25.
//

import SwiftUI

extension UserUpgradeView {
    func reputationView() -> some View {
        ScrollView {
            HStack {
                Text("REPUTATION")
                    .font(.title3)
                    .fontWidth(.expanded)
                Spacer()
                Text("CURRENT REPUTATION: \((userData.wrappedValue.airlineReputation * 100).withCommas)%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
            }
            if !userData.wrappedValue.campaignRunning {
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.callout)
                            Text("Temporary Marketing Campagin (10-25% increase)")
                                .fontWidth(.expanded)
                                .font(.callout)
                            Spacer()
                        }
                        buttonForCampaignItem(3, price: 1_000_000, userData: userData)
                        buttonForCampaignItem(6, price: 1_750_000, userData: userData)
                        buttonForCampaignItem(12, price: 3_000_000, userData: userData)
                        buttonForCampaignItem(24, price: 6_000_000, userData: userData)
                    }
                    .padding(5)
                    .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                    
                    VStack {
                        HStack {
                            Image(systemName: "leaf")
                                .font(.callout)
                            Text("Eco-friendly Marketing Campaign (5-15%) increase")
                                .fontWidth(.expanded)
                                .font(.callout)
                            Spacer()
                        }
                        
                        
                        buttonForCampaignItem(3, price: 1_000_000, userData: userData, range: 0.05...0.15)
                        buttonForCampaignItem(6, price: 1_750_000, userData: userData, range: 0.05...0.15)
                        buttonForCampaignItem(12, price: 3_000_000, userData: userData, range: 0.05...0.15)
                        buttonForCampaignItem(24, price: 6_000_000, userData: userData, range: 0.05...0.15)
                    }
                    .padding(5)
                    .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                }
            } else {
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    Text("A reputation campaign is already running, and has given you a \((userData.wrappedValue.campaignEffectiveness! * 100).withCommas)% boost in your airline's reputation, and will last for the next \(timeTakenForCampaignEnd(context.date, userData: userData.wrappedValue)).")
                        .fontWidth(.condensed)
                        .contentTransition(.numericText(countsDown: true))
                }
            }
        }
    }
}
