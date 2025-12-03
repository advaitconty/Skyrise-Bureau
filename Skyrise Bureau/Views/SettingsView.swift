//
//  SettingsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 3/12/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State var showNotificationsLog: Bool = false
    @ObservedObject var notificationsManager = NotificationsManager()
    var moidifiableUserdata: Binding<UserData> {
        Binding {
            userData.first ?? testUserData
        } set: { value in
            if let item = userData.first {
                item.preferredAirlineCodeType = value.preferredAirlineCodeType
                item.allowedNotificationTypes = value.allowedNotificationTypes
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
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
            }
            /// Code selection
            /// For selecting ICAO/IATA codes on the map
            HStack {
                Text("Preferred Code for Airports")
                    .fontWidth(.expanded)
                Spacer()
                Button {
                    withAnimation {
                        moidifiableUserdata.wrappedValue.preferredAirlineCodeType = "iata"
                    }
                } label: {
                    Text("IATA (e.g. AUH/LAX)")
                        .fontWidth(.condensed)
                }
                .buttonStyle(.borderedProminent)
                .tint(moidifiableUserdata.wrappedValue.preferedAirlineCodeType == .iata ? .accent : .gray)
                Button {
                    withAnimation {
                        moidifiableUserdata.wrappedValue.preferredAirlineCodeType = "icao"
                    }
                } label: {
                    Text("ICAO (e.g. OMAA/KLAX)")
                        .fontWidth(.condensed)
                }
                .buttonStyle(.borderedProminent)
                .tint(moidifiableUserdata.wrappedValue.preferedAirlineCodeType == .icao ? .accent : .gray)
            }
            /// Notification preferences manager
            HStack {
                Text("Notifications To Send")
                    .fontWidth(.expanded)
                Spacer()
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.arrival) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.arrival)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .arrival })
                        }
                    }
                } label: {
                    Text("Jet Arrival")
                        .fontWidth(.condensed)
                }
                .buttonStyle(.borderedProminent)
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.arrival) ? .accent : .gray)
                
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.maintainanceEnd)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .maintainanceEnd })
                        }
                    }
                } label: {
                    Text("End of Maintainance")
                        .fontWidth(.condensed)
                }
                .buttonStyle(.borderedProminent)
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) ? .accent : .gray)
                
                Button {
                    if !moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.append(.campaignEnd)
                        }
                    } else {
                        withAnimation {
                            moidifiableUserdata.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .campaignEnd })
                        }
                    }
                } label: {
                    Text("End of Campaign")
                        .fontWidth(.condensed)
                }
                .buttonStyle(.borderedProminent)
                .tint(moidifiableUserdata.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) ? .accent : .gray)
            }
            
            /// Notifications stats for nerds
            Group {
                Button {
                    withAnimation {
                        showNotificationsLog.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Notification stats for nerds")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(showNotificationsLog ? .accent : .gray)
                
                if showNotificationsLog {
                    if notificationsManager.returnAllNotificationScheduledForStatsForNerds().count == 0 {
                        HStack {
                            Text("All scheduled notifications: ".uppercased())
                                .fontWidth(.expanded)
                            +
                            Text("No scheduled notifications")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            HStack {
                                Text("All scheduled notifications: ".uppercased())
                                    .fontWidth(.expanded)
                                Spacer()
                            }
                            ForEach(notificationsManager.returnAllNotificationScheduledForStatsForNerds(), id: \.id) { notification in
                                Divider()
                                VStack {
                                    Text("\(notification.notificationTitle) - ")
                                        .fontWidth(.expanded)
                                    +
                                    Text("\(notification.notificationBody) - ")
                                        .fontWidth(.condensed)
                                    Text("Scheduled for ")
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
