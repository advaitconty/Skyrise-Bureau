//
//  Picker.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension AirplaneStoreView {
    func availableAirportPicker() -> some View {
        VStack {
            HStack {
                Text("Airport to deliver to")
                    .fontWidth(.condensed)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(userData.deliveryHubs.wrappedValue, id: \.uniqueID) { airport in
                        if airportToDeliverPlaneTo == airport {
                            Button {
                                withAnimation {
                                    airportToDeliverPlaneTo = airport
                                }
                            } label: {
                                Text("\(countryNameToEmoji(airport.country)) \(airport.reportCorrectCodeForUserData(userData.wrappedValue))")
                                    .fontWidth(.expanded)
                            }
                            .buttonStyle(.borderedProminent)
                            .transition(.blurReplace)
                        } else {
                            Button {
                                withAnimation {
                                    airportToDeliverPlaneTo = airport
                                }
                            } label: {
                                Text("\(countryNameToEmoji(airport.country)) \(airport.reportCorrectCodeForUserData(userData.wrappedValue))")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.bordered)
                            .transition(.blurReplace)
                        }
                    }
                }
            }
        }
        .onAppear {
            airportToDeliverPlaneTo = userData.deliveryHubs.wrappedValue[0]
        }
    }
}
