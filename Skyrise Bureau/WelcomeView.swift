//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 11/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var showWelcomeText: Bool = true
    @State var showLogoIcon: Bool = true
    var body: some View {
        VStack {
            HStack {
                if showLogoIcon {
                    Image(systemName: "airplane")
                        .transition(.move(edge: .trailing))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.default, completionCriteria: .logicallyComplete) {
                                    showWelcomeText = false
                                } completion: {
                                    withAnimation(completionCriteria: .removed) {
                                        showLogoIcon = false
                                    } completion: {
                                        print("Done")
                                    }
                                }
                                
                            }
                        }
                }
                if showWelcomeText {
                    Text("Welcome to Skyrise Bureau!")
                        .fontWidth(.expanded)
                }
            }
         }
    }
}

#Preview {
    WelcomeView()
}
