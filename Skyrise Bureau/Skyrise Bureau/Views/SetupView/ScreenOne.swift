//
//  ScreenOne.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import SwiftUI

extension SetupView {
    func firstScreenView() -> some View {
        VStack {
            if !moveOnFromInitialAnimation {
                HStack {
                    Spacer()
                    Image(systemName: "airplane")
                        .font(.largeTitle)
                    Text("Welcome to Skyrise Bureau!")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                    Spacer()
                }
                .transition(.move(edge: .trailing))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.snappy(duration: 0.75), completionCriteria: .removed) {
                            moveOnFromInitialAnimation = true
                        } completion: {
                            print("Moved")
                        }
                    }
                }
            } else {
                if #available(iOS 26.0, *) {
                    VStack {
                        HStack {
                            Text("Select an airline name to get started!")
                                .font(.title)
                                .fontWidth(.expanded)
                            Spacer()
                        }
                        HStack {
                            Text("Airline name:")
                                .fontWidth(.expanded)
                            TextField("Lufthansa", text: $userData.airlineName)
                                .monospaced()
                        }
                        .padding()
                        .glassEffect()
                        
                        HStack {
                            Text("Airline CEO:")
                                .fontWidth(.expanded)
                            TextField("Jens Ritter", text: $userData.name)
                                .monospaced()
                        }
                        .padding()
                        .glassEffect()
                        
                        HStack {
                            Text("IATA Code:")
                                .fontWidth(.expanded)
                            TextField("(e.g. SQ, BA, LH)", text: $userData.airlineIataCode)
                                .monospaced()
                                .onChange(of: userData.airlineIataCode) { oldValue, newValue in
                                    if newValue.count > 2 {
                                        userData.airlineIataCode = String(newValue.prefix(2))
                                    }
                                }
                        }
                        .padding()
                        .glassEffect()
                        
                        if !userData.airlineIataCode.isEmpty && !userData.name.isEmpty && !userData.airlineName.isEmpty {
                            Button {
                                withAnimation {
                                    screenNum += 1
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                        .fontWidth(.expanded)
                                }
                            }
                            .buttonStyle(.glassProminent)
                            .hoverEffect()
                        }
                    }
                    .transition(.blurReplace)
                } else {
                    VStack {
                        Text("Select an airline name to get started!")
                            .fontWidth(.expanded)
                        HStack {
                            Text("Airline name:")
                                .fontWidth(.expanded)
                            TextField("Lufthansa", text: $userData.airlineName)
                                .textFieldStyle(.roundedBorder)
                                .monospaced()
                        }
                        HStack {
                            Text("Airline CEO:")
                                .fontWidth(.expanded)
                            TextField("Jens Ritter", text: $userData.name)
                                .textFieldStyle(.roundedBorder)
                                .monospaced()
                        }
                        HStack {
                            Text("IATA Code:")
                                .fontWidth(.expanded)
                            TextField("(e.g. SQ, BA, LH)", text: $userData.airlineIataCode)
                                .textFieldStyle(.roundedBorder)
                                .monospaced()
                                .onChange(of: userData.airlineIataCode) { oldValue, newValue in
                                    if newValue.count > 2 {
                                        userData.airlineIataCode = String(newValue.prefix(2))
                                    }
                                }
                        }
                        if userData.airlineIataCode.isEmpty && userData.name.isEmpty && userData.airlineName.isEmpty {
                            Button {
                                withAnimation {
                                    screenNum += 1
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.right")
                                    Text("Next")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .transition(.blurReplace)
                }
            }
        }
    }
}
