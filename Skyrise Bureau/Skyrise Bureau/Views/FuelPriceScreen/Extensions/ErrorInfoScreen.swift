//
//  ErrorInfoScreen.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 26/11/25.
//

import SwiftUI

extension FuelPriceView {
    func errorInfoScreen(_ width: CGFloat) -> some View {
        VStack {
            if exceedMax && notEnoughBalance {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("ERROR")
                                .fontWidth(.expanded)
                            Spacer()
                        }
                        Text("You are trading for more fuel then you cash and holding capacity to trade for. Please decrease the amount of fuel you would like to trade for.")
                            .fontWidth(.condensed)
                    }
                    .frame(width: width / 2 - 55)
                    .padding(14)
                    .background(colorScheme == .dark ? .red.opacity(0.1) : .red.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            } else if notEnoughBalance {
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("ERROR")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    Text("You are trading for more fuel then you cash to trade for. Please decrease the amount of fuel you would like to trade for.")
                        .fontWidth(.condensed)
                }
                .frame(width: width / 2 - 55)
                .padding(14)
                .background(colorScheme == .dark ? .red.opacity(0.1) : .red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            } else if exceedMax {
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("ERROR")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    Text("You are trading for more fuel then you can carry. Please decrease the amount of fuel you would like to trade for.")
                        .fontWidth(.condensed)
                }
                .frame(width: width / 2 - 55)
                .padding(14)
                .background(colorScheme == .dark ? .red.opacity(0.1) : .red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
        }
    }
}
