//
//  SelectedJetView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI

extension MapManagerView {
    func selectedJetView() -> some View {
        VStack {
            HStack {
                if #available(iOS 26.0, *) {
                    Button {
                        withAnimation {
                            selectedJet = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.glass)
                } else {
                    Button {
                        withAnimation {
                            selectedJet = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.bordered)
                }
                Spacer()
            }
            HStack {
                Text("\(userData.planes[selectedJet!].registration) ")
                    .fontWidth(.compressed)
                +
                Text("(\(userData.planes[selectedJet!].aircraftname))")
                    .fontWidth(.condensed)
                Spacer()
                Text(userData.planes[selectedJet!].aircraftID)
                    .fontWidth(.condensed)
            }
            Image(userData.planes[selectedJet!].aircraftID)
                .resizable()
                .scaledToFit()
            Spacer()
        }
    }
}
