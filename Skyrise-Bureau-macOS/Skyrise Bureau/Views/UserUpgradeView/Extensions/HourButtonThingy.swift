//
//  HourButtonThingy.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 1/12/25.
//

import SwiftUI

extension UserUpgradeView {
    func buttonForCampaignItem(_ hour: Int, price: Double, userData: Binding<UserData>, range: ClosedRange<Double> = 0.10...0.25) -> some View {
        Button {
            let notificationManager = NotificationsManager()
            withAnimation {
                userData.wrappedValue.campaignRunning = true
                userData.wrappedValue.campaignEffectiveness = Double.random(in: range)
                userData.wrappedValue.accountBalance = userData.wrappedValue.accountBalance - price
                let secondsInFuture: TimeInterval = TimeInterval(hour * 60 * 60)
                let currentDate: Date = Date()
                userData.wrappedValue.campaignEnd = currentDate.addingTimeInterval(secondsInFuture)
                if userData.wrappedValue.airlineReputation + userData.wrappedValue.campaignEffectiveness! < 1 {
                    userData.wrappedValue.airlineReputation += userData.wrappedValue.campaignEffectiveness!
                } else {
                    userData.wrappedValue.airlineReputation = 1
                }
            }
            notificationManager.schedule(notificationType: .campaignEnd, planeInvolved: nil, date: userData.wrappedValue.campaignEnd!, userData: userData.wrappedValue)
        } label: {
            Image(systemName: "\(hour).circle")
            Text("\(hour)hr campaign")
                .fontWidth(.condensed)
            Spacer()
            Text("$\(price.withCommas)")
                .fontWidth(.condensed)
        }
        .buttonStyle(.bordered)
        .disabled(userData.wrappedValue.accountBalance < price)
    }
}
