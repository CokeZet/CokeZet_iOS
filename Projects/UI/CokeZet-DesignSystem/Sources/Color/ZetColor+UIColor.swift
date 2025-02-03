//
//  ZetColor+UIColor.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import UIKit

public extension ZetColor {
    var color: UIColor {
        guard let color = UIColor(hex: self.hex) else {
            return .white
        }

        return color
    }
}
