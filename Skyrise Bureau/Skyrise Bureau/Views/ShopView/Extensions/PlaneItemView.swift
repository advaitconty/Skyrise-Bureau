//
//  PlaneItemView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 4/12/25.
//

import SwiftUI

extension ShopView {
    func buttonLabel(plane: Aircraft) -> some View {
        VStack {
            VStack {
                Image(plane.modelCode)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 350 - 70, maxHeight: CGFloat(plane.customImageHeight))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .padding(10)
                    .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                    .aspectRatio(3/2, contentMode: .fit)
            }
            HStack {
                (Text("\(plane.name)\n")
                    .fontWidth(.expanded)
                +
                Text("$\(plane.purchasePrice.withCommas)")
                    .fontWidth(.condensed))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding([.leading, .trailing])
            
            HStack {
                littleSmallBoxThingy(icon: "ruler", item: "\(plane.maxRange)km")
                
                littleSmallBoxThingy(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                
                littleSmallBoxThingy(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
            }
        }
    }
}
