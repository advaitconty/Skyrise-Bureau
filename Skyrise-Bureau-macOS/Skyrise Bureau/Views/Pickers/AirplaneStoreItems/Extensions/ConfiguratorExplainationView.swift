//
//  ConfiguratorExplainationView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI

extension AirplaneStoreView {
    func explainationOnConfigurator() -> some View {
        ScrollView {
            HStack {
                Text("How does plane configuration work?")
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack {
                Text("Plane configuration works based on the types of classes you can fit a plane with, similar to real life. These classes are classified into 4 classes:")
                    .fontWidth(.condensed)
                Spacer()
            }
            HStack {
                Text("1. Economy class, the most basic of the bunch, and it costs the cheapest\n2. Premium economy class, the higher end economy. It often is a minor bump in price, but for slightly more roomier seats and nice food. However, these take up the space of 1.5 economy seats.\n3. Business class, where it really starts getting pricy. Passengers get to enjoy a nice lie-flat bed, the second largest entertainment screen in the sky and a lot more privacy compared to economy and premium economy. However, due to the lie-flat bed, this takes up the space of 3 economy class seats, or 2 premium economy class seats.\n4. First class, for the elite and VIPs. These passengers often get to enjoy private suites in the skies, entertainment screens the size of your home TV, full floor to cabin curtains and even their own personal minibar. However, this comes at the expense of taking up the place of 4 economy seats, or 2 business class seats.")
                    .fontWidth(.condensed)
                Spacer()
            }
            HStack {
                Text("Of course as the class increases, the amount of people willing to fly on that class decreases. Economy and premium economy tend to get the most amount of passengers.")
                    .fontWidth(.condensed)
                Spacer()
            }
        }
        .padding()
    }

}
