//
//  PluralisationExtension.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 3/12/25.
//

import Foundation

extension Int {
    func plu() -> String {
        return self == 1 ? "" : "s"
    }
}
