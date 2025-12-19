//
//  ShopView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 4/12/25.
//

import SwiftUI

struct ShopView: View {
    @Binding var userData: UserData
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius: CGFloat = 10.0
    @State var preferedSeatingConfig = SeatingConfig(economy: 0, premiumEconomy: 0, business: 0, first: 0)
    @State var searchTerm: String = ""
    @State var selectedPlane: Aircraft? = nil
    @State var showAllSeatsFilled: Bool = false
    @State var showNotAllSeatsFullWarning: Bool = false
    @State var aircraftName: String = "Horizon Jet"
    @State var registration: String = "SB-"
    
    var filteredPlanes: [Aircraft] {
        AircraftDatabase.shared.allAircraft.filter { plane in
            let matchesSearch = searchTerm.isEmpty || plane.name.localizedCaseInsensitiveContains(searchTerm) || plane.manufacturer.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            return matchesSearch
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Text("Jet Set Emporium\n")
                        .font(.largeTitle)
                        .fontWidth(.expanded)
                        +
                    Text("Current account balance: $\(userData.accountBalance.withCommas)")
                        .fontWidth(.condensed)
                    Spacer()
                        .onAppear {
                            /// DEBUG STUB
                            /// Remove upon final release
                            selectedPlane = filteredPlanes[52]
                        }
                    if #available(iOS 26.0, *) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .tint(.gray)
                        .hoverEffect()
                        .buttonStyle(.glass)
                    } else {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .tint(.gray)
                        .hoverEffect()
                    }
                }
                .padding([.top, .leading, .trailing])
                NavigationSplitView {
                    VStack {
                        List(filteredPlanes, selection: $selectedPlane) { plane in
                            NavigationLink(value: plane) {
                                buttonLabel(plane: plane)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    if #available(iOS 26.0, *) {
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search for planes", text: $searchTerm)
                                    .fontWidth(.condensed)
                                    .textFieldStyle(.automatic)
                            }.padding()
                        }
                        .glassEffect(.regular, in: Capsule())
                        .padding()
                    } else {
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search for planes", text: $searchTerm)
                                    .fontWidth(.condensed)
                                    .textFieldStyle(.automatic)
                            }.padding()
                        }
                        .padding()
                    }
                } detail: {
                    if selectedPlane != nil {
                        planeConfiguratorView(selectedPlane!)
                            .padding()
                    } else {
                        Text("Select a plane to get more information on it.")
                            .fontWidth(.expanded)
                    }
                }
                .navigationSplitViewStyle(.balanced)
                .onChange(of: selectedPlane) {
                    if selectedPlane != nil {
                        preferedSeatingConfig = selectedPlane!.defaultSeating
                    }
                }
            }
        }
    }
}

#Preview {
    ShopView(userData: .constant(testUserDataEndgame))
}
