//
//  PlaneStatsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI
import Foundation

extension AirplaneStoreView {
    func planeStatsView(plane: Aircraft) -> some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        showPlane = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12))
                    Text("Back")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                }
                Spacer()
            }
            Image(plane.modelCode)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            VStack {
                HStack {
                    Text(plane.name)
                        .font(.system(size: 36))
                        .fontWidth(.expanded)
                    Spacer()
                }
                Text(plane.description)
                    .font(.system(size: 16))
                    .fontWidth(.condensed)
            }
            .padding(5)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            HStack {
                littleSmallBoxThingy(icon: "ruler", item: "\(plane.maxRange)km")
                littleSmallBoxThingy(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                littleSmallBoxThingy(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
            }
            HStack {
                littleSmallBoxThingy(icon: "fuelpump", item: "\(plane.fuelBurnRate)L/km")
                littleSmallBoxThingy(icon: "road.lanes", item: "\(plane.minRunwayLength)m")
                littleSmallBoxThingy(icon: "dollarsign.circle", item: "$\(plane.maintenanceCostPerHour)/km")
            }
            VStack {
                HStack {
                    Text("Normal seating arrangement")
                        .fontWidth(.condensed)
                    Spacer()
                }
                HStack {
                    Image(systemName: "carseat.right")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.economy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "star")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.premiumEconomy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "briefcase")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.business)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "crown")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.first)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                }
            }
            .frame(maxWidth: 250, maxHeight: 50)
            .padding(5)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            if userData.accountBalance.wrappedValue > plane.purchasePrice {
                configuator(plane: plane)
                    .onAppear {
                        preferedSeatingConfig = plane.defaultSeating
                    }
                
                Button {
                    
                } label: {
                    Text("Purchase for $\(String(format: ".%2f", plane.purchasePrice))")
                }
            } else {
                HStack {
                    Image(systemName: "exclamationmark.octagon.fill")
                    Text("You do not have enough funds to purchase this plane")
                        .fontWidth(.condensed)
                }
            }
        }
        .padding()
    }

}
