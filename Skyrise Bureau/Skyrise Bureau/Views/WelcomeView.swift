//
//  WelcomeView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import SwiftUI

struct SetupView: View {
    @Binding var userData: UserData
    @State var screenNum: Int = 1
    @State var moveOnFromInitialAnimation: Bool = false
    var body: some View {
        VStack {
            if screenNum == 1 {
                firstScreenView()
            }
        }
        .padding()
    }
}

#Preview {
    SetupView(userData: .constant(testUserData))
}
