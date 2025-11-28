//
//  FirstPage.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension WelcomeView {
    func pageOneView() -> some View {
        VStack {
            if showLogo {
                HStack {
                    Image(systemName: "airplane")
                        .font(.title)
                        .foregroundColor(easterEggActivated ? .yellow : .primary)
                        .scaleEffect(easterEggActivated ? 1.3 : 1.0)
                        .rotationEffect(.degrees(easterEggActivated ? 360 : 0))
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: easterEggActivated)
                        .onTapGesture {
                            if !easterEggActivated {
                                easterEggTapCount += 1
                                if easterEggTapCount >= 7 {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
                                        easterEggActivated = true
                                        showEasterEggMessage = true
                                        // Give the user a starting bonus!
                                        userDataForAddition.accountBalance += 500_000
                                    }
                                }
                            }
                        }
                    Text("Welcome to Skyrise Bureau!")
                        .font(.title)
                        .fontWidth(.expanded)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.default, completionCriteria: .logicallyComplete) {
                                    showLogo = false
                                } completion: {
                                    withAnimation {
                                        showBody = true
                                    }
                                }
                            }
                        }
                }
                .transition(.push(from: .leading))
            }
            
            // Easter egg message
            if showEasterEggMessage {
                VStack {
                    Text("✨ Secret Bonus Unlocked! ✨")
                        .font(.headline)
                        .fontWidth(.expanded)
                        .foregroundColor(.yellow)
                    Text("You found the hidden easter egg!")
                        .font(.subheadline)
                        .fontWidth(.condensed)
                    Text("+$500,000 starting bonus!")
                        .font(.caption)
                        .fontWidth(.condensed)
                        .foregroundColor(.green)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.7))
                )
                .transition(.scale.combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        showEasterEggMessage = false
                    }
                }
                .onAppear {
                    // Auto-dismiss after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            showEasterEggMessage = false
                        }
                    }
                }
            }
            
            if showBody {
                VStack {
                    Text("Select an airline name to get started!")
                        .font(.title3)
                        .fontWidth(.expanded)
                    
                    HStack {
                        Text("Airline name")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("IndiGo Atlantic", text: $userDataForAddition.airlineName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("Airline CEO")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("Pieters Elbiers", text: $userDataForAddition.name)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("IATA Code")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("2-letter airline code (e.g., 6E, BA, SQ)", text: $userDataForAddition.airlineIataCode)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                            .onChange(of: userDataForAddition.airlineIataCode) { oldValue, newValue in
                                if newValue.count > 2 {
                                    userDataForAddition.airlineIataCode = String(newValue.prefix(2))
                                }
                            }
                    }
                }
                .transition(.blurReplace)
                .onChange(of: userDataForAddition.airlineIataCode) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
                .onChange(of: userDataForAddition.airlineName) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
                .onChange(of: userDataForAddition.name) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
            }
            if showNextForAirport {
                Button {
                    withAnimation(.default, completionCriteria: .removed) {
                        viewPage = 2
                    } completion: {
                        print("Done")
                    }
                } label: {
                    Image(systemName: "arrow.right")
                    Text("Next (select your airport)")
                        .fontWidth(.condensed)
                }
                .transition(.blurReplace)
            }
        }
        .transition(.slide)
    }
}
