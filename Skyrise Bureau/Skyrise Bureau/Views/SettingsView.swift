//
//  SettingsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var userData: UserData
    @Namespace var notifNamespace
    @Namespace var airportCodeNamespace
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "gearshape.2")
                    .font(.largeTitle)
                Text("Skyrise Bureau Settings")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
                if #available(iOS 26.0, *) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tint(.gray)
                    .buttonStyle(.glass)
                } else {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tint(.gray)
                    .buttonStyle(.plain)
                }
            }
            Spacer()
            // MARK: Notification settings stuff
            VStack {
                HStack {
                    Text("Preferred Airport Code Type:")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if #available(iOS 26.0, *) {
                        if userData.preferedAirlineCodeType == .iata {
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        }
                    } else {
                        if userData.preferedAirlineCodeType == .iata {
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "iata"
                                }
                            } label: {
                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
                            
                            
                            Button {
                                withAnimation {
                                    userData.preferredAirlineCodeType = "icao"
                                }
                            } label: {
                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.borderedProminent)
                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
                        }
                        
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("Preferred Notification Types:")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if #available(iOS 26.0, *) {
                        if userData.allowedNotificationTypes.contains(.arrival) {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.removeAll(where: { $0 == .arrival })
                                }
                            } label: {
                                Text("Aircraft Arrival")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.append(.arrival)
                                }
                            } label: {
                                Text("Aircraft Arrival")
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                        }
                        
                        if userData.allowedNotificationTypes.contains(.maintainanceEnd) {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.removeAll(where: { $0 == .maintainanceEnd })
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.append(.maintainanceEnd)
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                        }
                        
                        if userData.allowedNotificationTypes.contains(.campaignEnd) {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.removeAll(where: { $0 == .campaignEnd })
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                        } else {
                            Button {
                                withAnimation {
                                    userData.allowedNotificationTypes.append(.campaignEnd)
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView(userData: .constant(testUserData))
}
