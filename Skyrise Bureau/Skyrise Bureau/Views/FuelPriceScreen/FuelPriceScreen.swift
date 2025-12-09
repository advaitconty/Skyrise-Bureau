//
//  FuelPriceScreen.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 25/11/25.
//

import SwiftUI
import Charts
import SwiftData

struct FuelPriceItem: Codable, Identifiable {
    var id: UUID = UUID()
    var fuelPrice: Double
    var hour: Int
    
}

struct FuelPriceView: View {
    @Binding var userData: UserData
    @State var lastFewFuelPriceItem: [FuelPriceItem] = []
    @State var amountOfFuelUserWantsToPurchase: Double = 1000.0
    @Environment(\.colorScheme) var colorScheme
    @State var exceedMax: Bool = false /// SET TO FALSE LATER
    @State var notEnoughBalance: Bool = false /// SET TO FALSE LATER
    var buttonDisabledStatus: Bool {
        return exceedMax || notEnoughBalance
    }
    @Environment(\.dismiss) var dismiss
    
    func convertFuelPricesToChartItems(_ fuelPrices: [Double]) -> [FuelPriceItem] {
        return fuelPrices.enumerated().map { index, price in
            FuelPriceItem(fuelPrice: price, hour: index * 2)
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Text("Purchase Fuel")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                    Spacer()
                    VStack {
                        (Text("CURRENT BALANCE:\n")
                            .fontWidth(.condensed)
                            .font(.caption)
                        +
                         Text("$\(userData.accountBalance.withCommas)")
                            .font(.title3)
                            .fontWidth(.expanded))
                            .multilineTextAlignment(.trailing)
                            .contentTransition(.numericText(countsDown: true))
                    }
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.title)
                    }
                    .adaptiveButtonStyle()
                }
                HStack {
                    /// SwiftUI chart
                    /// Things that may work:
                    /// volatility, max high, max low
                    chartView()
                    .frame(width: reader.size.width / 2)
                    VStack {
                        HStack {
                            Text("CURRENT PRICE:")
                                .font(.callout)
                                .fontWidth(.condensed)
                            Spacer()
                            (Text("$\(Int(userData.currentFuelPrice))")
                                .font(.title)
                                .fontWidth(.expanded)
                            +
                            Text("\nfor 1000 kilos")
                                .font(.caption)
                                .fontWidth(.expanded))
                            .multilineTextAlignment(.trailing)
                            .contentTransition(.numericText(countsDown: true))
                        }
                        
                        textFieldItem()
                        
                        extraInformation(reader.size.width)
                            .padding([.bottom])
                        
                        errorInfoScreen(reader.size.width)
                        
                        Button {
                            withAnimation {
                                userData.currentlyHoldingFuel = userData.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase)
                                userData.accountBalance = userData.accountBalance - userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                            }
                            /// CLOSE WINDOW AFTER THIS
                        } label: {
                            Spacer()
                            Text("Execute fuel trade")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                        .disabled(buttonDisabledStatus)
                        .adaptiveProminentButtonStyle()
                        
                        
                        /// Current fuel capacity
                        VStack {
                            ProgressView(value: Double(userData.currentlyHoldingFuel)/Double(userData.maxFuelHoldable)) {
                                HStack {
                                    Text("CURRENT \nFUEL HOLD:\n")
                                        .font(.caption)
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("\(userData.currentlyHoldingFuel.withCommas)kg/\(userData.maxFuelHoldable.withCommas)kg")
                                        .fontWidth(.expanded)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2, reservesSpace: true)
                                        .contentTransition(.numericText(countsDown: true))
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: reader.size.width / 2)
                }
            }
            .onAppear {
                print(reader.size)
            }
        }
        .padding()
        .onAppear {
            let item = userData.lastFewFuelPricesForGraph
            lastFewFuelPriceItem = convertFuelPricesToChartItems(item)
        }
    }
}

var testUserDataModifiable = testUserData

struct FuelPriceView_Previews: PreviewProvider {
    static var previews: some View {
        FuelPriceView(userData: .constant(testUserDataEndgame))
    }
}
