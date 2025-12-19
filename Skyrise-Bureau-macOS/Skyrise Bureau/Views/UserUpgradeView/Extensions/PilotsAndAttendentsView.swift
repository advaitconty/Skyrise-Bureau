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
                Text("$\(userData.wrappedValue.weeklyPilotSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.wrappedValue.pilotHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Pilot salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double
                        if userData.wrappedValue.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyPilotSalary = userData.wrappedValue.weeklyPilotSalary + 50
                            userData.wrappedValue.pilotHappiness = userData.wrappedValue.pilotHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        var adder: Double
                        if userData.wrappedValue.pilotHappiness != 1 {
                             adder = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.pilotHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        } else {
                            adder = 0
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyPilotSalary = userData.wrappedValue.weeklyPilotSalary - 50
                            userData.wrappedValue.pilotHappiness = userData.wrappedValue.pilotHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .padding(5)
            .frame(width: 150, height: 140)
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
                Text("$\(userData.wrappedValue.weeklyFlightAttendentSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.wrappedValue.flightAttendentHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Flight attendent pricing logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if userData.wrappedValue.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyFlightAttendentSalary = userData.wrappedValue.weeklyFlightAttendentSalary + 50
                            userData.wrappedValue.flightAttendentHappiness = userData.wrappedValue.flightAttendentHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if userData.wrappedValue.flightAttendentHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.flightAttendentHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyFlightAttendentSalary = userData.wrappedValue.weeklyFlightAttendentSalary - 50
                            userData.wrappedValue.flightAttendentHappiness = userData.wrappedValue.flightAttendentHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .padding(5)
            .frame(width: 150, height: 140)
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
                Text("$\(userData.wrappedValue.weeklyFlightMaintainanceCrewSalary.withCommas)/week")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Text("\(String(Int(userData.wrappedValue.maintainanceCrewHappiness * 100)))%")
                    .fontWidth(.condensed)
                    .contentTransition(.numericText(countsDown: true))
                Spacer()
                /// Maintainance crew salary logic
                /// To implement in v1
                HStack {
                    Button {
                        var adder: Double = 0
                        if userData.wrappedValue.maintainanceCrewHappiness != 1 {
                            adder = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyFlightMaintainanceCrewSalary = userData.wrappedValue.weeklyFlightMaintainanceCrewSalary + 50
                            userData.wrappedValue.maintainanceCrewHappiness = userData.wrappedValue.maintainanceCrewHappiness + adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        var adder: Double = 0
                        if userData.wrappedValue.maintainanceCrewHappiness != 1 {
                            adder  = Double.random(in: 0.01...0.05)
                            while adder + userData.wrappedValue.maintainanceCrewHappiness > 1 {
                                adder = Double.random(in: 0.01...0.05)
                            }
                        }
                        withAnimation {
                            userData.wrappedValue.weeklyFlightMaintainanceCrewSalary = userData.wrappedValue.weeklyFlightMaintainanceCrewSalary - 50
                            userData.wrappedValue.maintainanceCrewHappiness = userData.wrappedValue.maintainanceCrewHappiness - adder
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .padding(5)
            .frame(width: 150, height: 140)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}
