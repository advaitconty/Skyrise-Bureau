//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 11/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var showLogo: Bool = true
    @State var showBody: Bool = false
    @State var error: Bool = false
    @State var errorText: String = ""
    @State var newAirlineName: String = ""
    
    
    var body: some View {
        VStack {
            if showLogo {
                HStack {
                    Image(systemName: "airplane")
                        .font(.title)
                    Text("Welcome to Skyrise Bureau!    ")
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
            if showBody {
                VStack {
                    Text("Select an airline name to get started!")
                        .font(.title3)
                        .fontWidth(.expanded)
                    
                    HStack {
                        Text("Airline name")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("Skyward Collective", text: $newAirlineName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                    }
                    
                    HStack {
                        Text("IATA Code")
                            .fontWidth(.expanded)
                        Spacer()
                        TextField("2-letter airline code (e.g., AA, BA, SQ)", text: $newAirlineName)
                            .textFieldStyle(.roundedBorder)
                            .monospaced()
                            .onChange(of: newAirlineName) { oldValue, newValue in
                                if newValue.count > 2 {
                                    newAirlineName = String(newValue.prefix(2))
                                }
                            }
                    }
                }
                .transition(.blurReplace)
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
    }
}

#Preview {
    WelcomeView()
}
