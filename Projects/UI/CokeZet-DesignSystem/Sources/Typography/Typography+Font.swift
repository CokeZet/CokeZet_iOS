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
    
    public var typeScale: TypeScale {
        switch self {
        case .extraBold(let scale): return scale
        case .bold(let scale): return scale
        case .semiBold(let scale): return scale
        case .medium(let scale): return scale
        }
    }
    
    /// 줄 수에 따라 다른 lineHeight 반환
    /// - Parameter numberOfLines: UILabel의 numberOfLines
    /// - Returns: 적절한 lineHeight 값
    public func lineHeight(forNumberOfLines numberOfLines: Int) -> CGFloat {
        let size = self.typeScale.size
        if numberOfLines == 1 {
            return size // 100%
        } else {
            return size * 1.5 // 150%
        }
    }
    
    /// TypeScale 별 letterSpacing 반환
    public var letterSpacing: CGFloat {
        switch self {
        case .extraBold(let scale),
             .bold(let scale),
             .semiBold(let scale),
             .medium(let scale):
            return scale.letterSpacing
        }
    }

    /// TypeScale 별 lineHeight 반환
    public var lineHeight: CGFloat {
        switch self {
        case .extraBold(let scale),
             .bold(let scale),
             .semiBold(let scale),
             .medium(let scale):
            return scale.lineHeight
        }
    }
}
