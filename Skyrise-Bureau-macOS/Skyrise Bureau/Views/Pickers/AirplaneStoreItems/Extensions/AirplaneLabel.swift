//
//  AirplaneLabel.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI
import Foundation

extension AirplaneStoreView {
    func buttonLabel(plane: Aircraft) -> some View {
        VStack {
            VStack {
                Image(plane.modelCode)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 350 - 50, maxHeight: CGFloat(plane.customImageHeight))
                    .padding(10)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                    .aspectRatio(3/2, contentMode: .fit)
            }
            .padding(3)
            
            
            HStack {
                Text(plane.name)
                    .font(.system(size: 24))
                    .fontWidth(.expanded)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            .padding(3)
            
            HStack {
                Text("$\(Int(plane.purchasePrice))")
                    .font(.system(size: 16))
                    .fontWidth(.compressed)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(3)
            
            HStack {
                littleSmallBoxThingy(icon: "ruler", item: "\(plane.maxRange)km")
                
                littleSmallBoxThingy(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                
                littleSmallBoxThingy(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
            }
            .padding(3)
            
        }
        .padding(3)
        .buttonStyle(.borderless)
        .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color(red: 237/225, green: 237/225, blue: 237/225))
        .frame(width: 350 - 50)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

}
