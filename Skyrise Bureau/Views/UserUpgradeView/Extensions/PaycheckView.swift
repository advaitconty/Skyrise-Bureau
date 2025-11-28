//
//  PaycheckView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import SwiftUI

extension UserUpgradeView {
    func paycheckView() -> some View { 
        VStack {
            HStack {
                Text("PAYCHECKS")
                    .font(.title3)
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack {
                salaryViewItem()
                Spacer()
            }
        }
    }
}
