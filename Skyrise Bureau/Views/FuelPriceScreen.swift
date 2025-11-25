//
//  FuelPriceScreen.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 25/11/25.
//

import SwiftUI
import Charts

struct FuelPriceItem: Codable, Identifiable {
    var id: UUID = UUID()
    var fuelPrice: Double
    var hour: Int
    
}

struct FuelPriceView: View {
    @Binding var userData: UserData
    @State var lastFewFuelPriceItem: [FuelPriceItem] = []
    @State var amountOfFuelUserWantsToPurchase: Double = 1000.0
    
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
                    Text("Current balance: $\(String(format: "%.2f", userData.accountBalance))")
                        .font(.callout)
                        .fontWidth(.condensed)
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Price over last 20 hours")
                                .font(.caption)
                                .fontWidth(.expanded)
                            Spacer()
                        }
                        Chart(lastFewFuelPriceItem, id: \.id) { price in
                            LineMark(x: .value("Fuel", price.hour), y: .value("Fuel Price", price.fuelPrice))
                        }
                    }
                    .frame(width: reader.size.width / 2)
                    VStack {
                        Text("Current price:\n")
                            .font(.callout)
                            .fontWidth(.condensed)
                        +
                        Text("$\(Int(userData.currentFuelPrice))/1000kg")
                            .font(.title)
                            .fontWidth(.expanded)
                        
                        HStack {
                            TextField("1000", value: $amountOfFuelUserWantsToPurchase, format: .number)
                                .fontWidth(.condensed)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(.roundedBorder)
                            Text("kg")
                                .fontWidth(.condensed)
                        }
                        
                        
                        // Extra information
                        VStack {
                            Text("Costing: ")
                                .fontWidth(.condensed)
                            +
                            Text("$\(Int(userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase))")
                                .font(.title2)
                                .fontWidth(.expanded)
                            
                            Text("\nLeaving you with ")
                                .fontWidth(.condensed)
                            +
                            Text(userData.accountBalance > userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase ? "\n$\(String(format: "%.2f", userData.accountBalance - userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase))" : "\nNot enough cash")
                                .font(.title2)
                                .fontWidth(userData.accountBalance > userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase ? .expanded : .condensed)
                            +
                            Text(userData.accountBalance > userData.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase ? "\nremaining in your bank account" : "\n(you'll be in the negatives)")
                                .fontWidth(.condensed)
                        }
                        
                        Button {
                            /// TODO: add logic here
                        } label: {
                            Text("Purchase fuel")
                                .fontWidth(.condensed)
                        }
                        
                        Divider()
                        
                        /// Current fuel capacity
                        VStack {
                            Text("Current fuel held:")
                                .font(.caption)
                                .fontWidth(.condensed)
                            Text("\(userData.currentlyHoldingFuel)kg/\(userData.maxFuelHoldable)kg")
                                .fontWidth(.expanded)
                        }
                        
                        /// CONSIDER:
                        /// adding new fuel capacity?
                    }
                    .padding()
                    .frame(width: reader.size.width / 2)
                }
            }
        }
        .padding()
        .onAppear {
            let item = userData.lastFewFuelPricesForGraph
            lastFewFuelPriceItem = convertFuelPricesToChartItems(item)
        }
    }
}

#Preview {
    FuelPriceView(userData: .constant(testUserDataEndgame))
}
