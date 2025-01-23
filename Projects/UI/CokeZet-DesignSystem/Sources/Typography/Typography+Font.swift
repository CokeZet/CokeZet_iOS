//
//  Typography+Font.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import UIKit

extension Typography {
    public var font: UIFont {
        switch self {
        case .T24:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 24)
        case .T22:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 22)
        case .T20:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 20)
        case .T18:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 18)
        case .T16:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 16)
        case .T14:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 14)
        case .T12:
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: 12)
        }
    }
}
