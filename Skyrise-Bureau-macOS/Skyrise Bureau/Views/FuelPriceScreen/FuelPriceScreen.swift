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
    @Query var actualUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    var userData: Binding<UserData> {
        Binding {
            actualUserData.first ?? testUserData
        } set: { value in
            if let item = actualUserData.first {
                item.planes = value.planes
                item.deliveryHubs = value.deliveryHubs
                item.airlineIataCode = value.airlineIataCode
                item.airlineName = value.airlineName
                item.name = value.name
                item.accountBalance = value.accountBalance
                item.airlineReputation = value.airlineReputation
                item.campaignEffectiveness = value.campaignEffectiveness
                item.campaignRunning = value.campaignRunning
                item.currentlyHoldingFuel = value.currentlyHoldingFuel
                item.flightAttendentHappiness = value.flightAttendentHappiness
                item.flightAttendents = value.flightAttendents
                item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                item.lastFuelPrice = value.lastFuelPrice
                item.levels = value.levels
                item.maintainanceCrew = value.maintainanceCrew
                item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                item.maxFuelHoldable = value.maxFuelHoldable
                item.pilotHappiness = value.pilotHappiness
                item.pilots = value.pilots
                item.pilotHappiness = value.pilotHappiness
                item.xp = value.xp
                
                try? modelContext.save()
            }
        }
    }
    @State var lastFewFuelPriceItem: [FuelPriceItem] = []
    @State var amountOfFuelUserWantsToPurchase: Double = 1000.0
    @Environment(\.colorScheme) var colorScheme
    @State var exceedMax: Bool = false /// SET TO FALSE LATER
    @State var notEnoughBalance: Bool = false /// SET TO FALSE LATER
    var buttonDisabledStatus: Bool {
        return exceedMax || notEnoughBalance
    }
    
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
                         Text("$\(userData.wrappedValue.accountBalance.withCommas)")
                            .font(.title3)
                            .fontWidth(.expanded))
                            .multilineTextAlignment(.trailing)
                            .contentTransition(.numericText(countsDown: true))
                    }
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
                            (Text("$\(Int(userData.wrappedValue.currentFuelPrice))")
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
                                userData.wrappedValue.currentlyHoldingFuel = userData.wrappedValue.currentlyHoldingFuel + Int(amountOfFuelUserWantsToPurchase)
                                userData.wrappedValue.accountBalance = userData.wrappedValue.accountBalance - userData.wrappedValue.currentFuelPrice/1000 * amountOfFuelUserWantsToPurchase
                            }
                            /// CLOSE WINDOW AFTER THIS
                        } label: {
                            Spacer()
                            Text("Execute fuel trade")
                                .fontWidth(.condensed)
                            Spacer()
                        }
                        .disabled(buttonDisabledStatus)
                        
                        
                        /// Current fuel capacity
                        VStack {
                            ProgressView(value: Double(userData.wrappedValue.currentlyHoldingFuel)/Double(userData.wrappedValue.maxFuelHoldable)) {
                                HStack {
                                    Text("CURRENT \nFUEL HOLD:\n")
                                        .font(.caption)
                                        .fontWidth(.condensed)
                                    Spacer()
                                    Text("\(userData.wrappedValue.currentlyHoldingFuel.withCommas)kg/\(userData.wrappedValue.maxFuelHoldable.withCommas)kg")
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
            let item = userData.wrappedValue.lastFewFuelPricesForGraph
            lastFewFuelPriceItem = convertFuelPricesToChartItems(item)
        }
        .frame(width: 800, height: 550)
    }
}

var testUserDataModifiable = testUserData

struct FuelPriceView_Previews: PreviewProvider {
    static var previews: some View {
        FuelPriceView()
    }
}
