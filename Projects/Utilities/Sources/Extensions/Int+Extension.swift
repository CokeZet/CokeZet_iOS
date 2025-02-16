//
//  Int+Extension.swift
//  CokeZet-Utilities
//
//  Created by Daye on 2/16/25.
//

import Foundation

public extension Int {
    var decimalFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let result = numberFormatter.string(for: self) else {
            return "0"
        }

        return result
    }
}
