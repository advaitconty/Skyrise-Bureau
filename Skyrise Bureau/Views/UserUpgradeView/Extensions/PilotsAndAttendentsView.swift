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
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        
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
            .frame(width: 150, height: 125)
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
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        
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
            .frame(width: 150, height: 125)
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
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Spacer()
                        Image(systemName: "arrowtriangle.up")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button {
                        
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
            .frame(width: 150, height: 125)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}
