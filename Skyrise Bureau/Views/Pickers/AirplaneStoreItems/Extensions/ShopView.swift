//
//  ShopView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import Foundation
import SwiftUI

extension AirplaneStoreView {
    func shopView(_ userData: UserData) -> some View {
        VStack {
            HStack {
                Text("Store")
                    .font(.system(size: 24))
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack {
                Text("Available Cash: \(String(format: ".%0f", userData.accountBalance))")
                    .font(.system(size: 14))
                    .fontWidth(.condensed)
                Spacer()
            }
            TextField("Search for a plane...", text: $searchTerm)
                .font(.system(size: 16))
                .fontWidth(.condensed)
                .textFieldStyle(.roundedBorder)
                .padding([.bottom], 7)
            
            ScrollView {
                LazyVStack(spacing: 7, pinnedViews: []) {
                    ForEach(filteredPlanes, id: \.id) { plane in
                        Button {
                            withAnimation {
                                showPlaneStats = plane
                                showPlane = true
                            }
                        } label: {
                            buttonLabel(plane: plane)
                        }
                        .buttonStyle(.borderless)
                        
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, -8)
            .scrollContentBackground(.hidden)
        }
        .padding()
        .frame(width: 350, height: 700)
    }

}
