//
//  MSeriesCheck.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 6/12/25.
//

import Foundation
import SwiftUI

/// Read the device model identifier (e.g. "iPad16,3")
func deviceModelIdentifier() -> String {
    var sys = utsname()
    uname(&sys)
    let mirror = Mirror(reflecting: sys.machine)
    let id = mirror.children.compactMap { $0.value as? Int8 }
                     .prefix(while: { $0 != 0 })
                     .map { String(UnicodeScalar(UInt8($0))) }
                     .joined()
    return id
}

struct DeviceInfo {
    /// Known M-series iPad model identifiers (M1..M5). Update this set when Apple ships new models.
    static let mSeriesModelIDs: Set<String> = [
        // M1
        "iPad13,4","iPad13,5","iPad13,6","iPad13,7",
        "iPad13,8","iPad13,9","iPad13,10","iPad13,11",
        // M2
        "iPad14,3","iPad14,4","iPad14,5","iPad14,6",
        // M3
        "iPad15,3","iPad15,4","iPad15,5","iPad15,6",
        // M4
        "iPad16,3","iPad16,4","iPad16,5","iPad16,6",
        // M5
        "iPad17,1","iPad17,2","iPad17,3","iPad17,4"
    ]

    /// True if the current device matches a known M-series iPad model identifier.
    static var isMSeriesIPad: Bool {
        let id = deviceModelIdentifier()
        return mSeriesModelIDs.contains(id)
    }

    /// Convenience: returns the raw model identifier and whether it's M-series.
    static var modelAndIsMSeries: (modelIdentifier: String, isMSeries: Bool) {
        let id = deviceModelIdentifier()
        return (id, mSeriesModelIDs.contains(id))
    }
}
