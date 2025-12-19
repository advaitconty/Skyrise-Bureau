//
//  DateExtension.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 16/11/25.
//

import Foundation

extension Date {
    func adding(hours: Double) -> Date {
        self.addingTimeInterval(hours * 3600)
    }
}
