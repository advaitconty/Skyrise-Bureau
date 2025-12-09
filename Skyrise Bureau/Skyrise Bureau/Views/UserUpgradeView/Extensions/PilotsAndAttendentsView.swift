//
//  PilotsAndAttendentsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI
import Foundation

extension UserUpgradeView {
    func salaryViewItem() -> some View {
        HStack {
            VStack {
                Text("PILOTS")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                Text("$\(userData.weeklyPilotSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.pilotHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Pilot salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double
                        if userData.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + userData.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            userData.weeklyPilotSalary = userData.weeklyPilotSalary + 50
                            userData.pilotHappiness = userData.pilotHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.green)
                    
                    Button {
                        var adder: Double
                        if userData.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + userData.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            userData.weeklyPilotSalary = userData.weeklyPilotSalary - 50
                            userData.pilotHappiness = userData.pilotHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            VStack {
                Text("ATTENDENTS")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "bell")
                    .font(.system(size: 36))
                Text("$\(userData.weeklyFlightAttendentSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.flightAttendentHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Flight attendent pricing logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if userData.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.weeklyFlightAttendentSalary = userData.weeklyFlightAttendentSalary + 50
                            userData.flightAttendentHappiness = userData.flightAttendentHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if userData.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.weeklyFlightAttendentSalary = userData.weeklyFlightAttendentSalary - 50
                            userData.flightAttendentHappiness = userData.flightAttendentHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            VStack {
                Text("MAINTENANCE")
                    .font(.caption2)
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                Spacer()
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 36))
                Text("$\(userData.weeklyFlightMaintainanceCrewSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.maintainanceCrewHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Maintainance crew salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if userData.maintainanceCrewHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.weeklyFlightMaintainanceCrewSalary = userData.weeklyFlightMaintainanceCrewSalary + 50
                            userData.maintainanceCrewHappiness = userData.maintainanceCrewHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if userData.maintainanceCrewHappiness != 1 {
                            adder  = Double.random(in: 0.01...0.05)
                            while adder + userData.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.weeklyFlightMaintainanceCrewSalary = userData.weeklyFlightMaintainanceCrewSalary - 50
                            userData.maintainanceCrewHappiness = userData.maintainanceCrewHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .adaptiveProminentButtonStyle()
                    .tint(.red)
                }
            }
            .padding()
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}
