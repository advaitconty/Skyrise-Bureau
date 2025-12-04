//
//  SeatingChecker.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI
import Foundation

extension AirplaneStoreView {
    func doSeatingChecks(_ plane: Aircraft) {
        if preferedSeatingConfig.seatsUsed < Double(plane.maxSeats) {
            withAnimation {
                showNotAllSeatsFilled = true
            }
        } else if preferedSeatingConfig.seatsUsed > Double(plane.maxSeats) {
            withAnimation {
                showAllSeatsFileld = true
            }
        } else {
            withAnimation {
                showNotAllSeatsFilled = false
                showAllSeatsFileld = false
            }
        }
    }

}
