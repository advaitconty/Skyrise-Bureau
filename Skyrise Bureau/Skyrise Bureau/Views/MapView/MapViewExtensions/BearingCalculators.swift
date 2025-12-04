//
//  BearingCalculators.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import Foundation
import SwiftUI

extension MapView {
    func getBearing(from: Airport, to: Airport) -> Double {
        let lat1 = from.latitude * .pi / 180
        let lon1 = from.longitude * .pi / 180
        
        let lat2 = to.latitude * .pi / 180
        let lon2 = to.longitude * .pi / 180
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansBearing * 180 / .pi
    }
}
