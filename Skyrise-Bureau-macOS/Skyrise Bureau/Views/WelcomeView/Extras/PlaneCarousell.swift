//
//  PlaneCarousell.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension WelcomeView {
    func carousell(jet1: String, jet2: String) -> some View {
        VStack {
            if carousellItem == 1 {
                Image(jet1)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 2
                            }
                        }
                    }
            } else if carousellItem == 2 {
                Image(jet2)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 1
                            }
                        }
                    }
            }
        }
        .frame(width: 160, height: 90)
    }

}
