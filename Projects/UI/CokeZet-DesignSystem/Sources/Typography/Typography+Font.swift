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
        case .extraBold(let scale):
            return CokeZetDesignSystemFontFamily.Suit.bold.font(size: scale.size)
        case .bold(let scale):
            return CokeZetDesignSystemFontFamily.Suit.bold.font(size: scale.size)
        case .semiBold(let scale):
            return CokeZetDesignSystemFontFamily.Suit.semiBold.font(size: scale.size)
        case .medium(let scale):
            return CokeZetDesignSystemFontFamily.Suit.medium.font(size: scale.size)
        }
    }

    public var letterSpacing: CGFloat? {
        return nil
    }

    public var lineHeight: CGFloat? {
        return nil
    }
}
