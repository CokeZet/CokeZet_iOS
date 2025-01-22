//
//  UIColor+Extension.swift
//  CokeZet-Utilities
//
//  Created by Daye on 1/22/25.
//

import UIKit

public extension UIColor {
    /// Hex code(String) -> UIColor 변환
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        let scan = Scanner(string: cString).scanHexInt64(&rgbValue)
        if !scan { return nil }

        let r = CGFloat((rgbValue & 0xFF0000) >> 16)
        let g = CGFloat((rgbValue & 0x00FF00) >> 8)
        let b = CGFloat(rgbValue & 0x0000FF)

        if r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255 {
            return nil
        }

        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: alpha
        )
    }
}
