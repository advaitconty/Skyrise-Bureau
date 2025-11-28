//
//  PlaneOptions.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension WelcomeView {
    func option(icon: String, name: String, jet1: String, jet2: String, jet1Full: String, jet2Full: String, startingCapital: String, focus: String, option: Int) -> some View {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .font(.title)
                    Text(name)
                        .font(.title)
                        .fontWidth(.expanded)
                }
                carousell(jet1: jet1, jet2: jet2)
                Text(focus)
                    .fontWidth(.condensed)
                HStack {
                    Image(systemName: "airplane")
                    Text("Starting fleet")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Spacer()
                }
                .frame(maxWidth: 160)


                Text(jet1Full)
                    .fontWidth(.condensed)
                Text(jet2Full)
                    .fontWidth(.condensed)
                HStack {
                    Text("Starting capital")
                        .font(.title2)
                        .fontWidth(.expanded)
                    Text(startingCapital)
                        .font(.title2)
                        .fontWidth(.condensed)
                }
            }
            .padding()
            .frame(width: 350 - 50, height: 300)
            .background(fleetChoice == option ? .blue : (colorScheme == .dark ? Color(red: 18/255, green: 18/255, blue: 18/255) : Color(red: 237/255, green: 237/255, blue: 237/255)))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            .onTapGesture {
                withAnimation {
                    fleetChoice = option
                }
            }
    }

}
