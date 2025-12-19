//
//  NumberCommas.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 20/11/25.
//

import Foundation

extension Double {
    var withCommas: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension Int {
    var withCommas: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
